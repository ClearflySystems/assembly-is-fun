# assembly-is-fun
Because Solidity is a higher level language, often we need to optimise the Gas execution costs by managing memory better than the compiler can.
To do that we can use the lower level Assembly language which allows us to manage the memory stack more efficiently.
An example when this is useful is during loops like sorting algorithms or when building params for internal EVM calls.
This can often halve or more the Gas costs compared to executing in Solidity.

Clone Project then run yarn install to install packages.
`yarn install`

Then compile any contracts.
`yarn hardhat compile`

Execute any tests
`yarn hardhat test`
