// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

/// example of sort functions using Assembly to demonstrate gas efficencies in varying sorting algorithms.
/// with selectionsort being nearly twice as gas efficient as bubblesort.
/// note these are not production ready, more work is needed so they can work with dynamic array lengths and options for desc vs asc
/// more info on sorting algorithms - https://www.programiz.com/dsa/bubble-sort
/// example test array: [250, 36, 999, 845, 3, 49, 8710, 65, 1, 54]
contract Arraysort {

    /// @dev Return an ordered array of integers in asc order using bubble sort algorithm
    /// @param unsortedArray - unsorted int array
    /// @return sortedArray
    function bubblesort(uint256[10] calldata unsortedArray) external pure returns (uint256[10] memory sortedArray){
        sortedArray = unsortedArray;
        uint256 n = unsortedArray.length;
        assembly {
            let p := add(sortedArray, 0x0)
            for { let i := 0 } lt(i, sub(n, 1)) { i := add(i, 1) } {
                for { let j := 0 } lt(j, sub(n, i)) { j := add(j, 1) } {
                    let a := mload(add(p, mul(j, 0x20)))
                    let b := mload(add(p, mul(add(j, 1), 0x20)))

                    let cmp := lt(a,b)

                    if iszero(cmp) {
                        mstore(add(p, mul(j, 0x20)), b)
                        mstore(add(p, mul(add(j, 1), 0x20)), a)
                    }
                }
            }
        }
        return sortedArray;
    }

    /// @dev Return an ordered array of integers in asc order using selection sort algorithm
    /// @param unsortedArray - unsorted int array
    /// @return sortedArray
    function selectionsort(uint256[10] calldata unsortedArray) external pure returns (uint256[10] memory sortedArray){
        sortedArray = unsortedArray;
        uint256 n = unsortedArray.length;
        assembly {
            let p := add(sortedArray, 0x0)
            for { let i := 0 } lt(i, sub(n, 1)) { i := add(i, 1) } {

                let idx := i

                for { let j := add(i, 1) } lt(j, n) { j := add(j, 1) } {

                    let a := mload(add(p, mul(j, 0x20)))
                    let b := mload(add(p, mul(idx, 0x20)))

                    if lt(a,b) {
                        idx := j
                    }
                }

                let c := mload(add(p, mul(idx, 0x20)))
                let d := mload(add(p, mul(i, 0x20)))
                mstore(add(p, mul(i, 0x20)), c)
                mstore(add(p, mul(idx, 0x20)), d)
            }
        }
        return sortedArray;
    }

}