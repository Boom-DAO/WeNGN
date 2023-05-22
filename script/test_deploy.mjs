import { ethers } from "ethers";

import {readFileSync} from "fs";

// for local test
let provider = new ethers.JsonRpcProvider("http://127.0.0.1:8545");

//await provider.getBlockNumber()

let signer = await provider.getSigner(0);

console.log(signer.address);

let json_file = readFileSync("out/WrappedENaira.sol/WrappedENaira.json");

let json_values = JSON.parse(json_file);

let abi = json_values["abi"];

let contract_address = "0x5fbdb2315678afecb367f032d93f642f64180aa3";

let wrapped = new ethers.Contract(contract_address, abi, signer);

let sym = await wrapped.symbol();

console.log(sym);

let total = await wrapped.totalSupply();
console.log(total);
const amount = ethers.parseUnits("1.0", 18);

let tx = await wrapped.burn(amount);

await tx.wait()

// let tx = await wrapped.mint(signer.address, amount);

// await tx.wait()

total = await wrapped.totalSupply();
console.log(total);

// let amountuser1 = await wrapped.balanceOf(signer.address);

// console.log(amountuser1);

// let user2 = "0x70997970C51812dc3A010C7d01b50e0d17dc79C8";
// const amount = ethers.parseUnits("1.0", 18);

// let tx = await wrapped.transfer(user2, amount);

// await tx.wait()

// amountuser1 = await wrapped.balanceOf(signer.address);

// console.log(amountuser1);

// let amountuser2 = await wrapped.balanceOf(user2);

// console.log(amountuser2);
