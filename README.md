# Remix_SmartContracts - Tender
The smart contract is developed with Solidity programming language, it is Ethereum’s original coding language. Solidity is an object-oriented, high-level language for implementing smart contracts and it was influenced by C++, Python and JavaScript and is designed to target the Ethereum Virtual Machine (EVM). 
We have used Remix IDE to develop and test our smart contract. Remix is a powerful, open source tool that helps you write Solidity contracts straight from the browser. Written in JavaScript, Remix supports both usage in the browser and locally. It is also supports testing, debugging and deploying of smart contracts so easily.
The idea is belong to us and we have developed all codes by ourselves.
Our contract is about tender: If any company wants to collect offers of other companies and select the lowest or highest offer automatically, this contract is the good and more secure way to do it.
Now, we will explain every code line by line:
 
-	First of all, we have define the compiler of the solidity version as 0.4.20.
-	Then, we have define our contract as ‘Tender’
-	Next we have defined our variables, which will be used in our functions later.
o	address public owner: It is used for declare the owner of the contract, who has some special privilege on our contract, for example: only owner can start or kill our contract. The type of variable is an address which is unique identifier for users. This information is public so every users participated in the contract can see the address of the owner.
Addresses: The Ethereum blockchain is made up of accounts, which you can think of like bank accounts. An account has a balance of Ether (the currency used on the Ethereum blockchain), and you can send and receive Ether payments to other accounts, just like your bank account can wire transfer money to other bank accounts.
Each account has an address, which you can think of like a bank account number. It’s a unique identifier that points to that account, and it looks like this:
0x0cE446255506E92DF4164C46F1d6df9Cc969183
Address can be owned by specific user or smart contract
o	uint public numberOfCompany: It is used for declare the number of company who has given an offer. This is used for controlling the maximum number of companies who can offer. In other words, when the number of companies who send offers is equal to X, just complete the tender and publish the winner company. This information is public so every users participated in the contract can see the total number of companies.
o	address[] public offeringCompanies: It is in a type of array and stored address of the companies, who send offer to our contract. This array also public, so companies can see the offering companies address (just address, not name or offer’s value or other info).
Arrays: When you want a collection of something, you can use an array. There are two types of arrays in Solidity: fixed and dynamic arrays
We can also create an array of structs. 
Remember that state variables are stored permanently in the blockchain? So creating a dynamic array of structs like this can be useful for storing structured data in your contract, kind of like a database.
If you declare an array as public, other contracts would then be able to read from, but not write to, this array. So this is useful pattern for storing public data in your contract
o	uint public minValue: It is used for the minimum value of the offer. In other words, companies can not offer below this amount. This amount is public, so they can see the minimum base. It is defined before the contract is published by the owner of the contract.
o	Uint private minOffer: It is used for holds the minimum offer value, at the end the company who has send this amount of offer will win the tender. This is private value, so nobody can see this value (if they can see, it can effect their offer). This value is used only in contract.

NOTE: In solidity, functions or variables can be public or private. If it is public, this means anyone (or ay other contracts) can call your contract’s function and executes its code.
Obviously, this isn’t always desirable, and can make your contract vulnerable to attacks. Thus it’s good practice to mark your functions as private by default, and then only make public the functions you want to expose to the world.
If any function or variable is private, this mean only other functions within our contract will be able to call this function or variable. 

 
-	Struct: Structs allow you to create more complicated data types that have multiple properties. We have cerate a struct as ‘OfferCompany’ which contains the address of company, company name and, the value they offer. With struct we can collect different types of data which are belongs to the same company.

 
-	Mapping: Mappings are another way of storing organized data in Solidity. It is is essentially a key-value store for storing and looking up data. In our example, the key is an uint value and the value is a struct. In other words, we have mapped ‘OfferCompany’ struct with the numbers as 1,2,3,… etc as companyInfo. So we can call and used it easily in the following functions.

 
-	Construction() function: It is is executed at initialization and sets the owner of the contract. It set owner as msg.sender (who calls the function). And the minimum value of the offer is set by the owner of the contract. 
Msg.sender: In solidity, there are certain global variables that are available to all functions. One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function.
NOTE: In Solidity, function execution always needs to start with an external caller. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.
Using msg.sender gives you the security of the Ethereum blockchain --- the only way someone can modify someone else’s data would be to steal the private key associated with their Ethereum address.
-	Kill() function: This function is like a insurance of the contract. It is used to recover the funds on the contract.

 


-	CheckCompanyExist() function: This function is private function, it is called internal by the contract (it can not be called external). This function checks the company has offered before or not. So it prevents offering more than 1. In other words, each company can offer only once. In this function there is for loop for the array of offeringCompanies addresses, if the company address is available in our array, it means that company has offered before ant this function return true, otherwise it returns false.

 

-	MinOffer() function: This function is also private and called only by our contract internally. When any company send their offer to our contract we have checked if it is below or above the minimum value. If it is below the minimum value so it replace minimum value with the new offer. In other words, we have compare all offers only with the lowest value so there is less operation to find minimum offer. So the gas paid by the companies is also less. (This function is gas-saved function to optimize our operation).
GAS – the fuel Ethereum DApps run on: In Solidity, your users have to pay every time they execute a function on your DApp using a currency called gas. Users buy gas with Ether (the currency on Ethereum), so your users have to spend ETH in order to execute functions on your DApp.
How much gas is required to execute a function depends on how complex that function’s logic is. Each individual operation has a gas cost based roughly on how much computing resources will be required to perform that operation (e.g. writing to storage is much more expensive than adding two integers). The total gas cost of your function is the sum of the gas costs of all its individual operations.
Because running function costs real money for your users, code optimization is much more important in Ethereum than in other programming languages. If your code is sloppy, your users are going to have to pay a premium to execute your functions – and this could add up to millions of dollars in unnecessary fees across thousands of users.

 
-	Offer() function: Tis function is called by the companies externally to send their offers. Because it is called only external, the type of it external. This function needs two parameters, company name and the value of the offer by the company. So, when the companies call this function, they have sent their names and offering values. 
There are two requirement: one of them is check the company has the offer or not to prevent double offering by the same company. The other requirement is to check the amount of offering value is equal or more than our minimum offering value (base value). Stop executing if any of the requirement is not true.
If the requirements are satisfied, we have increment the number of the total companies and we have add this new company to our struct. The address comes automatically with msg.sender, who called the function. 
Lastly, we have compare the offering value with the previous lowest offering value. To do that we call the MinOffer() function internally. If the new offering value is lower, so we have set minValue with new one.
External is similar to public, except that these functions can ONLY be called outside the contract --- they can’t be called by other functions inside that contract.


 

-	TenderWinnerCompany() function: This function is used to publish the winner of the tender. View function, meaning it’s only viewing the data but not modifying it. Also, view function doesn’t consume gas. 
We have requirement to check total number of the offering company. It means, if the number of offering company is equal to 3, stop collecting offer and publish the winner of the contract. We have given 3 to test it easily. In real world, it should be big number to collect more offer. It depends on the decision. Also, it can be limitation of time not the number of company, so you can collect all offers between some dates.
At eh end , we have checked the minOffer value with our struct data and we have publish the name of the winner company. So, the other companies can see the name of the winner company.
NOTE: View functions don’t cost any gas when they’re called externally by a user.This because view functions don’t actually change anything on the blockchain – they only read the data. So marking a function with view tells web3.js that it only needs to query your local Ethereum node to run the function, and it doesn’t actually have to create a transaction on the blockchain (which would need to be run on every single node, and cost gas).
NOTE: If a function is called internally from another function in the same contract that is not a view function, it will still cost a gas. This is because the other function creates a transaction on Ethereum, and will still need to be verified from every node. So view functions are only free when they’re called.

