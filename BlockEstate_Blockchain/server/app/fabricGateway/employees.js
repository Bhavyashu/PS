const invoke = require('../fabricOps/invoke');
const query = require('../fabricOps/query')
const config = require('../../config/constants');
const log4js = require('log4js');
const { urlencoded } = require('body-parser');
const crypto = require('../utils/cryptography');
const ipfs_util = require('../utils/ipfs_service');

const add = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        const result = await invoke.invokeTransaction(config.channelName, config.chaincodeName, "AddEmployee", req.body, username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const update = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        const result = await invoke.invokeTransaction(config.channelName, config.chaincodeName, "UpdateEmployee", req.body, username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const getOne = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        let payloadForSmartcontract = [];
        payloadForSmartcontract.push(JSON.stringify(req.body));
        const result = await query.queryChaincode(config.channelName, config.chaincodeName, payloadForSmartcontract, "ReadEmployee", username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const deleteRecord = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;
       
        const result = await invoke.invokeTransaction(config.channelName, config.chaincodeName, "DeleteEmployee", req.body, username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const getAll = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        const result = await query.queryChaincode(config.channelName, config.chaincodeName, null, "GetAllEmployees", username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const addPrivate = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        var payload;
        if (req.files != null) {
            payload = await processPvtDataRequest(req);
        } else {
            payload = JSON.parse(req.body.params);
        } 
        const result = await invoke.invokeTransaction(config.channelName, config.chaincodeName, "AddPrivateData", payload, username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const processPvtDataRequest = async (req) => {
    const params = JSON.parse(req.body.params);
    const files = req.files.file;

    if (files.length) {
        for (var i = 0; i < files.length; i++) {
            files[i].data = crypto.encrypt(files[i].data);
        }
    } else {
        files.data = crypto.encrypt(files.data);
    }

    try {
        ipfs_json = await ipfs_util.uploadToIPFS(files)
        var payload = ({ ...params, imageUrl: ipfs_json })
        return payload
    } catch (error) {
        throw new Error(error);
    }
}

const getPvtData = async (req) => {
    try {
        let username = req.headers.userid;
        let orgName = req.headers.org;

        let payload = [];
        payload.push(JSON.stringify(req.body));
        console.log("request")
        console.log(payload);
        const result = await query.queryChaincode(config.channelName, config.chaincodeName, payload, "QueryPvtRecordByEmpId", username, orgName);
        return (result);
    } catch (error) {
        throw error.message.toString();
    }
}

const getIpfsFile = async (req) => {
    try {
        const file_buffer = await ipfs_util.getIpfsFile(req.body.props.cid);
        const decrypt_buffer = crypto.decrypt(file_buffer);
        return (decrypt_buffer);
    } catch (error) {
        throw error.message.toString();
    }
}

module.exports = {
    add,
    update,
    getOne,
    deleteRecord,
    getAll,
    addPrivate,
    getPvtData,
    getIpfsFile
}
