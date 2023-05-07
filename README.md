# Real Estate Blockchain Web App

This is a blockchain-powered web application built using Hyperledger Fabric to manage real estate transactions. The application uses a permissioned and kafka architecture to ensure security, transparency and consistency throughout the blockchain network.

## Project Structure

The project has the following four main sub-folders:

1. `chaincode`: This folder contains the smart contract code written in Go language. These smart contracts define the business logic and the rules that govern the real estate transactions.

2. `network`: This folder contains the blockchain network configuration files and scripts written in shell. It defines the architecture and workings of the blockchain network. The network is hosted as a Docker containers network using Docker Compose and YAML files.

3. `server`: This folder contains the backend code, which acts as a server for the requests received from the frontend via HTTP. The REST APIs are written in this folder to serve the interaction between the frontend and the blockchain network using FabricOPS and FabricSDK.

4. `client-ui`: This folder contains the frontend code written in ReactJS. It communicates with the server using API endpoints for the exchange of payloads and requests/responses.

## Getting Started

To run the application, follow these steps:

1. Clone the repository.

2. Navigate to the root folder of the project.

3. Install the required dependencies :
   - Docker, Docker-compose
   - Setting up Go Lang environment
   - NPM
   - Node.js
   - ReactJS
 

4. Start the blockchain network by navigating to the `network` folder, run the chmod command to give necessary permissions and then navigate to `local` folder to start blockchain by running the init.sh script:
   
   A)permissions
   ```
   chmod -R 777 local
   ```
   B)starting blockcain
   ```
   ./init.sh
   ```

6. Start the server by navigating to the `server` folder and running the following command:

   ```
   npm install
   node app
   ```

7. Start the client UI by navigating to the `client-ui` folder and running the following command:

   ```
   npm install
   npm run start
   ```

   This will start the application and launch it in your default browser.

## Conclusion

This project demonstrates how Hyperledger Fabric can be used to build decentralized applications that ensure transparency, security, and trust in real estate transactions.
