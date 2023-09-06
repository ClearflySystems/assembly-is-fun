import {expect} from "chai";
import {ethers} from "hardhat";
import {Arraysort} from "../typechain-types";

describe("Test Array Sort functions", () => {

    let ArraysortContract: Arraysort;

    /* Define known mixed arrays and sorted values as known test results */

    // test with empty array
    const a0: Array<number> = [];

    // test with one array value
    const a1: Array<number> = [7];

    // test with 2 array values
    const a2: Array<number> = [876, 23];
    const a2_asc: Array<number> = [23, 876];
    const a2_dsc: Array<number> = [876, 23];

    // test with 3 array values
    const a3: Array<number> = [95, 1, 6532];
    const a3_asc: Array<number> = [1, 95, 6532];
    const a3_dsc: Array<number> = [6532, 95, 1];

    // test with duplicate values
    const a4: Array<number> = [95, 1, 6532, 95];
    const a4_asc: Array<number> = [1, 95, 95, 6532];
    const a4_dsc: Array<number> = [6532, 95, 95, 1];

    // test with arrays containing 0
    const a10: Array<number> = [95, 1, 6532, 34, 10, 98562, 560, 2223, 0, 1000];
    const a10_asc: Array<number> = [0, 1, 10, 34, 95, 560, 1000, 2223, 6532, 98562];
    const a10_dsc: Array<number> = [98562, 6532, 2223, 1000, 560, 95, 34, 10, 1, 0];

    // test with large number range
    const a11: Array<number> = [95, 1, 6532, 34, 10, 98562, 560, 2223, 999, 2, 1000000001];
    const a11_asc: Array<number> = [1, 2, 10, 34, 95, 560, 1000, 2223, 6532, 98562, 1000000001];
    const a11_dsc: Array<number> = [1000000001, 98562, 6532, 2223, 999, 560, 95, 34, 10, 2, 1];

    // deploy contract before each test
    beforeEach(async () => {
        const ContractFactory  = await ethers.getContractFactory("Arraysort");
        ArraysortContract = await ContractFactory.deploy();
    });

    it("Test Bubble Sort against known values", async () => {
        const result: Array<bigint> = await ArraysortContract.bubblesort(a10);
        // use deep eq to compare bigint[] v number[]
        expect(result).deep.eq(a10_asc);
    });

    it("Test Selection Sort against known values", async () => {
        const result: Array<bigint> = await ArraysortContract.selectionsort(a10);
        // use deep eq to compare bigint[] v number[]
        expect(result).deep.eq(a10_asc);
    });

    it("Test input Array wrong length - should fail", async () => {
        const result: Array<bigint> = await ArraysortContract.selectionsort(a1);
    });

});