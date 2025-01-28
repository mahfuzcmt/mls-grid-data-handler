package com.bitsoft.mls

class GlobalConfig {

    public static final def USER_TYPE = [
            ADMINISTRATOR: "ADMINISTRATOR",
            OPERATOR: "OPERATOR",
    ]

    public static final def COUNTER_TYPE = [
            AGENT: "AGENT",
            OWN: "OWN",
    ]

    public static final def SEAT_FORMAT = [
            3: "1x2",
            4: "2x2",
    ]

    public static final def CITY_NAME = [
            DHAKA: "DHAKA",
            FARIDPUR: "FARIDPUR",
            GAZIPUR: "GAZIPUR",
            GOPALGANJ: "GOPALGANJ",
            KISHORGANJ: "KISHORGANJ",
            MADARIPUR: "MADARIPUR",
            MANIKGANJ: "MANIKGANJ",
            MUNSIGANJ: "MUNSIGANJ",
            NARAYANGANJ: "NARAYANGANJ",
            NARSHINDI: "NARSHINDI",
            RAJBARI: "RAJBARI",
            SARIATPUR: "SARIATPUR",
            TANGAIL: "TANGAIL",
            BANDARBAN: "BANDARBAN",
            BRAHAMANBARIA: "BRAHAMANBARIA",
            CHANDPUR: "CHANDPUR",
            CHITTAGONG: "CHITTAGONG",
            COMILLA: "COMILLA",
            COXSBAZAR: "COX'S BAZAR",
            FENI: "FENI",
            KHAGRACHORI: "KHAGRACHORI",
            LAKSHMIPUR: "LAKSHMIPUR",
            NOAKHALI: "NOAKHALI",
            RANGAMATI: "RANGAMATI",
            BARGUNA: "BARGUNA",
            BARISHAL: "BARISHAL",
            BHOLA: "BHOLA",
            JHALOKATHI: "JHALOKATHI",
            PATUAKHALI: "PATUAKHALI",
            PIROJPUR: "PIROJPUR",
            HOBIGANJ: "HOBIGANJ",
            MOULOVIBAZAR: "MOULOVIBAZAR",
            SHUNAMGANJ: "SHUNAMGANJ",
            SYLHET: "SYLHET",
            BOGRA: "BOGRA",
            CHAPAINAWABGANJ: "CHAPAINAWABGANJ",
            JOYPURHAT: "JOYPURHAT",
            PABNA: "PABNA",
            NAOGAON: "NAOGAON",
            NATORE: "NATORE",
            RAJSHAHI: "RAJSHAHI",
            SHIRAJGANJ: "SHIRAJGANJ",
            BAGERHAT: "BAGERHAT",
            CHUADANGA: "CHUADANGA",
            JESSORE: "JESSORE",
            JHENAIDAH: "JHENAIDAH",
            KHULNA: "KHULNA",
            KUSHTIA: "KUSHTIA",
            MAGURA: "MAGURA",
            MEHERPUR: "MEHERPUR",
            NARAIL: "NARAIL",
            SHATKHIRA: "SHATKHIRA",
            DINAJPUR: "DINAJPUR",
            GAIBANDHA: "GAIBANDHA",
            KURIGRAM: "KURIGRAM",
            LALMONIRHAT: "LALMONIRHAT",
            NILPHAMARI: "NILPHAMARI",
            PANCHAGARH: "PANCHAGARH",
            RANGPUR: "RANGPUR",
            THAKURGAON: "THAKURGAON",
            MYMENSINGH: "MYMENSINGH",
            SHERPUR: "SHERPUR",
            JAMALPUR: "JAMALPUR",
            NETROKONA: "NETROKONA",
    ]

    public static Integer itemsPerPage() {
        return 50
    }
}
