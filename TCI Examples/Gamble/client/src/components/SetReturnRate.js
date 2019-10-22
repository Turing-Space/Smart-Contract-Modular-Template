import React, { Component } from "react";

export default class SetReturnRate extends Component {

    constructor(props) {
        super(props);
        this.state = {
            accounts: props.accounts,
            contract: props.contract
        }
    }
    
    setReturnRate = async() => {
        const { accounts, contract } = this.state;
        
        await contract.methods.setReturnRate(this.returnRate.value).send({from: accounts[0]});
    };

    render() {
        return (
            <div>
                設定賠率
                <input type="text" ref={input => this.returnRate = input} defaultValue="20"/>
                <button type="button" onClick= {this.setReturnRate}> Set </button>
            </div>
        );
    }
}