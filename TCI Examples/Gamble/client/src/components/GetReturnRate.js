import React, { Component } from "react";

export default class GetReturnRate extends Component {

    constructor(props) {
        super(props);
        this.state = {
            contract: props.contract
        }
    }

    getReturnRate = async() => {
        const { contract } = this.state;
    
        const returnRate = await contract.methods.returnRate().call();
        this.setState({ returnRate: returnRate});
    };

    render() {
        return (
            <div>
                現在賠率：{this.state.returnRate / 10}
                <span>&nbsp;&nbsp;&nbsp;</span>
                <button type="button" onClick= {this.getReturnRate}> 查詢 </button>
            </div>
        );
    }
}