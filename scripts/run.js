const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('InsecurePasswordManager');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    let txn = await nftContract.generatePassword()
    await txn.wait()

    txn = await nftContract.generatePassword()
    await txn.wait()

    console.log(await nftContract.getTotalGeneratedPasswords())
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();
