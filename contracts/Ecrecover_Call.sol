// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;


/// Calling the pre-compiled contract ecrecover() at address 0x01
/// https://www.evm.codes/precompiled?fork=shanghai
/// In solidity you can just call ecrecover(h,_v,_r,_s) but this is a more gas efficient method using inline assembly/yul
/// https://soliditydeveloper.com/ecrecover
contract A {

    /// @dev Return the Public address that signed the message/transaction
    /// @dev Params are obtained from the TX data or by splitting the TX signature
    /// @param _h - TX Message Hash (not signature hash)
    /// @param _v - Recovery identifier, normally either 27 or 28
    /// @param _r - Signature R.x
    /// @param _s - Signature proof for R.x
    /// @return uint256 - remainder
    function ecrecover(bytes32 _h, uint8 _v, bytes32 _r, bytes32 _s) external view returns (address) {

        /// Create Hash with prefix
        bytes32 hash = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _h));

        assembly {
            // Set Free Memory Pointer
            let p := mload(0x40)

            // Add the 4 params to memory
            mstore(p, hash)
            mstore(add(p, 0x20), _v)
            mstore(add(p, 0x40), _r)
            mstore(add(p, 0x60), _s)

            // make the external staticcall() with params:
            // gas, ecrecover contract address, pointer, length of calldata, return data overwrites pointer, data size returned
            if iszero(staticcall(not(0), 0x01, p, 0x80, p, 0x20)) {
                revert(0, 0)
            }

            // terminate contract returning value at pointer
            return(p, 0x20)
        }
    }

}