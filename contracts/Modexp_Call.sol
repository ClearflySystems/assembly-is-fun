// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

/// Calling the pre-compiled contract modexp located at address 0x05
/// https://www.evm.codes/precompiled?fork=shanghai
contract A {

    /// @dev Calculates the remainder of ((b^e) / m)
    /// @param _b - Base integer
    /// @param _e - Exponent
    /// @param _m - Modulo
    /// @return uint256 - remainder
    function modexp(uint256 _b, uint256 _e, uint256 _m) external returns (uint256) {
        assembly {
            /// Set Free Memory Pointer
            let p := mload(0x40)

            /// First 3 params are Byte size of B, E, M (32 Bytes each)
            mstore(p, 0x20)
            mstore(add(p, 0x20), 0x20)
            mstore(add(p, 0x40), 0x20)

            /// Next 3 params are the values passed in for B, E, M
            mstore(add(p, 0x60), _b)
            mstore(add(p, 0x80), _e)
            mstore(add(p, 0xa0), _m)

            /// make the external call() with params:
            /// gas, modexp contract address, zero, pointer, length of data, return data overwrites pointer, data size returned
            if iszero( call(not(0), 0x05, 0x0, p, 0xc0, p, 0x20) ) {
                revert(0,0)
            }

            /// terminate contract returning value at pointer
            return(p, 0x20)
        }
    }
}