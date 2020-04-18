import React, { Component } from "react";

class GetBankerBalance extends Component {
    constructor(props) {
        super(props);
        this.state = {
            contract: props.contract,
            bankerBalanace: 0
        }
    }

    getBankerBalance = async() => {
        const { contract } = this.state;
        
        const bankerBalanace = await contract.methods.getBalance().call();
        this.setState({ bankerBalanace: bankerBalanace});
    };

    render() {
        return (
            <div>
                莊家資本額： {this.state.bankerBalanace}
                <span>&nbsp;&nbsp;&nbsp;</span>
                <button type="button" onClick= {this.getBankerBalance}> 查詢 </button>
            </div>
        );
    }
}

export default GetBankerBalance;