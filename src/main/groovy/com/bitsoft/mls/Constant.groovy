package com.bitsoft.mls

class Constant {

    static getCASE_TYPE() {
        return [
                "INTERNAL"  : "Internal",
                "HIGH_COURT": "High Court",
        ]
    }
    static getSTATUS_TYPE() {
        return [
                "ACTIVE"  : "Active",
                "INACTIVE": "Inactive",
        ]
    }

    static getCASE_STATUS() {
        return [
                "PENDING"  : "Pending",
                "RESOLVED": "Resolved",
                "DISMISSED": "Dismissed",
        ]
    }

    static getPAYMENT_STATUS() {
        return [
                "PENDING"  : "Pending",
                "UNPAID": "Unpaid",
                "PAID": "Paid",
        ]
    }

}
