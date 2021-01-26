window.onload = function(){
    // 전세
    const inputLeft1 = document.querySelector("#input-left1");
    const inputRight1 = document.querySelector("#input-right1");
    const thumbLeft1 = document.querySelector("#thumb-left1");
    const thumbRight1 = document.querySelector("#thumb-right1");
    const range1 = document.querySelector("#range1");
    const priceMin1 = document.querySelector("#priceMin1");
    const cp1 = document.querySelector("#cp1");
    const priceMax1 = document.querySelector("#priceMax1");
    const cp2 = document.querySelector("#cp2");

    // 가격 저장
    var cpMin;
    var cpMax;

    function setLeftValue1(e) {
        const target = e.target;
        const {value, min, max} = target;

        if (+inputRight1.value - +value < 1) {
            target.value = +inputRight1.value - 1;
        }

        const percent = (+target.value / 25) * 100;

        thumbLeft1.style.left = percent + "%";
        range1.style.left = percent + "%";


        // 가격 변동 범위 설정
        if (+target.value === +min && +inputRight1.value === +max) {
            priceMin1.textContent = "";
            cp1.textContent = "전체";
            priceMax1.textContent = "";
            cp2.textContent = "";
            cpMin = 0;
        } 
        else if (+target.value === +min) {
            priceMin1.textContent = "";
            cp1.textContent = "";
            cp2.textContent = "까지";
            cpMin = 0;
        } 
        else {
            if (+inputRight1.value === +max) {
                cp1.textContent = "부터";
                priceMax1.textContent = "";
                cp2.textContent = "";
            } 
            else {
                cp1.textContent = " ~ ";
                cp2.textContent = "";
            }
            switch (+target.value) {
                case 1:
                    cpMin = 5000000;
                    priceMin1.textContent = "500";
                    break;
                case 2:
                    cpMin = 7000000;
                    priceMin1.textContent = "700";
                    break;
                case 3:
                    cpMin = 10000000;
                    priceMin1.textContent = "1000";
                    break;
                case 4:
                    cpMin = 20000000;
                    priceMin1.textContent = "2000";
                    break;
                case 5:
                    cpMin = 30000000;
                    priceMin1.textContent = "3000";
                    break;
                case 6:
                    cpMin = 40000000;
                    priceMin1.textContent = "4000";
                    break;
                case 7:
                    cpMin = 50000000;
                    priceMin1.textContent = "5000";
                    break;
                case 8:
                    cpMin = 60000000;
                    priceMin1.textContent = "6000";
                    break;
                case 9:
                    cpMin = 70000000;
                    priceMin1.textContent = "7000";
                    break;
                case 10:
                    cpMin = 80000000;
                    priceMin1.textContent = "8000";
                    break;
                case 11:
                    cpMin = 90000000;
                    priceMin1.textContent = "9000";
                    break;
                case 12:
                    cpMin = 100000000;
                    priceMin1.textContent = "1억";
                    break;
                case 13:
                    cpMin = 150000000;
                    priceMin1.textContent = "1억 5000";
                    break;
                case 14:
                    cpMin = 200000000;
                    priceMin1.textContent = "2억";
                    break;
                case 15:
                    cpMin = 250000000;
                    priceMin1.textContent = "2억 5000";
                    break;
                case 16:
                    cpMin = 300000000;
                    priceMin1.textContent = "3억";
                    break;
                case 17:
                    cpMin = 350000000;
                    priceMin1.textContent = "3억 5000";
                    break;
                case 18:
                    cpMin = 400000000;
                    priceMin1.textContent = "4억";
                    break;
                case 19:
                    cpMin = 450000000;
                    priceMin1.textContent = "4억 5000";
                    break;
                case 20:
                    cpMin = 500000000;
                    priceMin1.textContent = "5억";
                    break;
                case 21:
                    cpMin = 700000000;
                    priceMin1.textContent = "7억";
                    break;
                case 22:
                    cpMin = 1000000000;
                    priceMin1.textContent = "10억";
                    break;
                case 23:
                    cpMin = 1500000000;
                    priceMin1.textContent = "15억";
                    break;
                case 24:
                    cpMin = 2000000000;
                    priceMin1.textContent = "20억";
                    break;
            }
        }
        document.querySelector("input[name=charter_min]").value = cpMin;
    };

    function setRightValue1(e) {
        const target = e.target;
        const {value, min, max} = target;

        if (+value - +inputLeft1.value < 1) {
            target.value = +inputLeft1.value + 1;
        }

        const percent = (+target.value / 25) * 100;

        thumbRight1.style.right = (100 - percent) + "%";
        range1.style.right = (100 - percent) + "%";

        // 가격 변동 범위 설정
        if (+target.value === +max && +inputLeft1.value === +min) {
            priceMin1.textContent = "";
            cp1.textContent = "전체";
            priceMax1.textContent = "";
            cp2.textContent = "";
            cpMax = "max";
        } 
        else {
            if (+inputLeft1.value === +min) {
                priceMin1.textContent = "";
                cp1.textContent = "";
                cp2.textContent = "까지";
            } 
            else {
                cp1.textContent = " ~ ";
                cp2.textContent = "";
            }
            switch (+target.value) {
                case 1:
                    cpMax = 5000000;
                    priceMax1.textContent = "500";
                    break;
                case 2:
                    cpMax = 7000000;
                    priceMax1.textContent = "700";
                    break;
                case 3:
                    cpMax = 10000000;
                    priceMax1.textContent = "1000";
                    break;
                case 4:
                    cpMax = 20000000;
                    priceMax1.textContent = "2000";
                    break;
                case 5:
                    cpMax = 30000000;
                    priceMax1.textContent = "3000";
                    break;
                case 6:
                    cpMax = 40000000;
                    priceMax1.textContent = "4000";
                    break;
                case 7:
                    cpMax = 50000000;
                    priceMax1.textContent = "5000";
                    break;
                case 8:
                    cpMax = 60000000;
                    priceMax1.textContent = "6000";
                    break;
                case 9:
                    cpMax = 70000000;
                    priceMax1.textContent = "7000";
                    break;
                case 10:
                    cpMax = 80000000;
                    priceMax1.textContent = "8000";
                    break;
                case 11:
                    cpMax = 90000000;
                    priceMax1.textContent = "9000";
                    break;
                case 12:
                    cpMax = 100000000;
                    priceMax1.textContent = "1억";
                    break;
                case 13:
                    cpMax = 150000000;
                    priceMax1.textContent = "1억 5000";
                    break;
                case 14:
                    cpMax = 200000000;
                    priceMax1.textContent = "2억";
                    break;
                case 15:
                    cpMax = 250000000;
                    priceMax1.textContent = "2억 5000";
                    break;
                case 16:
                    cpMax = 300000000;
                    priceMax1.textContent = "3억";
                    break;
                case 17:
                    cpMax = 350000000;
                    priceMax1.textContent = "3억 5000";
                    break;
                case 18:
                    cpMax = 400000000;
                    priceMax1.textContent = "4억";
                    break;
                case 19:
                    cpMax = 450000000;
                    priceMax1.textContent = "4억 5000";
                    break;
                case 20:
                    cpMax = 500000000;
                    priceMax1.textContent = "5억";
                    break;
                case 21:
                    cpMax = 700000000;
                    priceMax1.textContent = "7억";
                    break;
                case 22:
                    cpMax = 1000000000;
                    priceMax1.textContent = "10억";
                    break;
                case 23:
                    cpMax = 1500000000;
                    priceMax1.textContent = "15억";
                    break;
                case 24:
                    cpMax = 2000000000;
                    priceMax1.textContent = "20억";
                    break;
                case 25:
                    priceMax1.textContent = "";
                    cp1.textContent = "부터";
                    cp2.textContent = "";
                    cpMax = "max";
                    break;
            }
        }
        document.querySelector("input[name=charter_max]").value = cpMax;
    };

    if (inputLeft1 && inputRight1) {
        inputLeft1.addEventListener("input", setLeftValue1);
        inputRight1.addEventListener("input", setRightValue1);
    }

    
    // 월세
    const inputLeft2 = document.querySelector("#input-left2");
    const inputRight2 = document.querySelector("#input-right2");
    const thumbLeft2 = document.querySelector("#thumb-left2");
    const thumbRight2 = document.querySelector("#thumb-right2");
    const range2 = document.querySelector("#range2");
    const priceMin2 = document.querySelector("#priceMin2");
    const mp1 = document.querySelector("#mp1");
    const priceMax2 = document.querySelector("#priceMax2");
    const mp2 = document.querySelector("#mp2");

    // 가격 저장
    var mpMin;
    var mpMax;

    function setLeftValue2(e){
        const target = e.target;
        const {value, min, max} = target;

        if(+inputRight2.value - +value < 1){
            target.value = +inputRight2.value - 1;
        }

        const percent = (+target.value / 20) * 100;

        thumbLeft2.style.left = percent + "%";
        range2.style.left = percent + "%";

        
        // 가격 변동 범위 설정
        if(+target.value === +min && +inputRight2.value === +max){
            priceMin2.textContent = "";
            mp1.textContent = "전체";
            priceMax2.textContent = "";
            mp2.textContent = "";
            mpMin = 0;
        }
        else if(+target.value === +min){
            priceMin2.textContent = "";
            mp1.textContent = "";
            mp2.textContent = "까지";
            mpMin = 0;
        }
        else{
            if (+inputRight2.value === +max) {
                mp1.textContent = "부터";
                priceMax2.textContent = "";
                mp2.textContent = "";
            } 
            else {
                mp1.textContent = " ~ ";
                mp2.textContent = "";
            }
            switch(+target.value){
                case 1:
                    mpMin = 50000;
                    priceMin2.textContent = "5";
                    break;
                case 2:
                    mpMin = 100000;
                    priceMin2.textContent = "10";
                    break;
                case 3:
                    mpMin = 200000;
                    priceMin2.textContent = "20";
                    break;
                case 4:
                    mpMin = 250000;
                    priceMin2.textContent = "25";
                    break;
                case 5:
                    mpMin = 300000;
                    priceMin2.textContent = "30";
                    break;
                case 6:
                    mpMin = 350000;
                    priceMin2.textContent = "35";
                    break;
                case 7:
                    mpMin = 400000;
                    priceMin2.textContent = "40";
                    break;
                case 8:
                    mpMin = 500000;
                    priceMin2.textContent = "50";
                    break;
                case 9:
                    mpMin = 600000;
                    priceMin2.textContent = "60";
                    break;
                case 10:
                    mpMin = 700000;
                    priceMin2.textContent = "70";
                    break;
                case 11:
                    mpMin = 1000000;
                    priceMin2.textContent = "100";
                    break;
                case 12:
                    mpMin = 1500000;
                    priceMin2.textContent = "150";
                    break;
                case 13:
                    mpMin = 2000000;
                    priceMin2.textContent = "200";
                    break;
                case 14:
                    mpMin = 2500000;
                    priceMin2.textContent = "250";
                    break;
                case 15:
                    mpMin = 3000000;
                    priceMin2.textContent = "300";
                    break;
                case 16:
                    mpMin = 3500000;
                    priceMin2.textContent = "350";
                    break;
                case 17:
                    mpMin = 4000000;
                    priceMin2.textContent = "400";
                    break;
                case 18:
                    mpMin = 4500000;
                    priceMin2.textContent = "450";
                    break;
                case 19:
                    mpMin = 5000000;
                    priceMin2.textContent = "500";
                    break;
            }
        }
        document.querySelector("input[name=monthly_min]").value = mpMin;
    };
    
    function setRightValue2(e){
        const target = e.target;
        const {value, min, max} = target;

        if(+value - +inputLeft2.value < 1){
            target.value = +inputLeft2.value + 1;
        }

        const percent = (+target.value / 20) * 100;

        thumbRight2.style.right = (100-percent) + "%";
        range2.style.right = (100-percent) + "%";

        // 가격 변동 범위 설정
        if(+target.value === +max && +inputLeft2.value === +min){
            priceMin2.textContent = "";
            mp1.textContent = "전체";
            priceMax2.textContent = "";
            mp2.textContent = "";
            mpMax = "max";
        }
        else{
            if (+inputLeft2.value === +min) {
                priceMin2.textContent = "";
                mp1.textContent = "";
                mp2.textContent = "까지";
            } 
            else {
                mp1.textContent = " ~ ";
                mp2.textContent = "";
            }
            switch (+target.value) {
                case 1:
                    mpMax = 50000;
                    priceMax2.textContent = "5";
                    break;
                case 2:
                    mpMax = 100000;
                    priceMax2.textContent = "10";
                    break;
                case 3:
                    mpMax = 200000;
                    priceMax2.textContent = "20";
                    break;
                case 4:
                    mpMax = 250000;
                    priceMax2.textContent = "25";
                    break;
                case 5:
                    mpMax = 300000;
                    priceMax2.textContent = "30";
                    break;
                case 6:
                    mpMax = 350000;
                    priceMax2.textContent = "35";
                    break;
                case 7:
                    mpMax = 400000;
                    priceMax2.textContent = "40";
                    break;
                case 8:
                    mpMax = 500000;
                    priceMax2.textContent = "50";
                    break;
                case 9:
                    mpMax = 600000;
                    priceMax2.textContent = "60";
                    break;
                case 10:
                    mpMax = 700000;
                    priceMax2.textContent = "70";
                    break;
                case 11:
                    mpMax = 1000000;
                    priceMax2.textContent = "100";
                    break;
                case 12:
                    mpMax = 1500000;
                    priceMax2.textContent = "150";
                    break;
                case 13:
                    mpMax = 2000000;
                    priceMax2.textContent = "200";
                    break;
                case 14:
                    mpMax = 2500000;
                    priceMax2.textContent = "250";
                    break;
                case 15:
                    mpMax = 3000000;
                    priceMax2.textContent = "300";
                    break;
                case 16:
                    mpMax = 3500000;
                    priceMax2.textContent = "350";
                    break;
                case 17:
                    mpMax = 4000000;
                    priceMax2.textContent = "400";
                    break;
                case 18:
                    mpMax = 4500000;
                    priceMax2.textContent = "450";
                    break;
                case 19:
                    mpMax = 5000000;
                    priceMax2.textContent = "500";
                    break;
                case 20 :
                    priceMax2.textContent = "";
                    mp1.textContent = "부터";
                    mp2.textContent = "";
                    mpMax = "max";
                    break;
            }
        }
        document.querySelector("input[name=monthly_max]").value = mpMax;
    };

    if(inputLeft2 && inputRight2){
        inputLeft2.addEventListener("input", setLeftValue2);
        inputRight2.addEventListener("input", setRightValue2);
    }

    // 보증금
    const inputLeft3 = document.querySelector("#input-left3");
    const inputRight3 = document.querySelector("#input-right3");
    const thumbLeft3 = document.querySelector("#thumb-left3");
    const thumbRight3 = document.querySelector("#thumb-right3");
    const range3 = document.querySelector("#range3");
    const priceMin3 = document.querySelector("#priceMin3");
    const mmp1 = document.querySelector("#mmp1");
    const priceMax3 = document.querySelector("#priceMax3");
    const mmp2 = document.querySelector("#mmp2");

    // 가격 저장
    var mmpMin;
    var mmpMax;

    function setLeftValue3(e) {
        const target = e.target;
        const {value, min, max} = target;

        if (+inputRight3.value - +value < 1) {
            target.value = +inputRight3.value - 1;
        }

        const percent = (+target.value / 25) * 100;

        thumbLeft3.style.left = percent + "%";
        range3.style.left = percent + "%";


        // 가격 변동 범위 설정
        if (+target.value === +min && +inputRight3.value === +max) {
            priceMin3.textContent = "";
            mmp1.textContent = "전체";
            priceMax3.textContent = "";
            mmp2.textContent = "";
            mmpMin = 0;
        } 
        else if (+target.value === +min) {
            priceMin3.textContent = "";
            mmp1.textContent = "";
            mmp2.textContent = "까지";
            mmpMin = 0;
        } 
        else {
            if (+inputRight3.value === +max) {
                mmp1.textContent = "부터";
                priceMax3.textContent = "";
                mmp2.textContent = "";
            } 
            else {
                mmp1.textContent = " ~ ";
                mmp2.textContent = "";
            }
            switch (+target.value) {
                case 1:
                    mmpMin = 5000000;
                    priceMin3.textContent = "500";
                    break;
                case 2:
                    mmpMin = 7000000;
                    priceMin3.textContent = "700";
                    break;
                case 3:
                    mmpMin = 10000000;
                    priceMin3.textContent = "1000";
                    break;
                case 4:
                    mmpMin = 20000000;
                    priceMin3.textContent = "2000";
                    break;
                case 5:
                    mmpMin = 30000000;
                    priceMin3.textContent = "3000";
                    break;
                case 6:
                    mmpMin = 40000000;
                    priceMin3.textContent = "4000";
                    break;
                case 7:
                    mmpMin = 50000000;
                    priceMin3.textContent = "5000";
                    break;
                case 8:
                    mmpMin = 60000000;
                    priceMin3.textContent = "6000";
                    break;
                case 9:
                    mmpMin = 70000000;
                    priceMin3.textContent = "7000";
                    break;
                case 10:
                    mmpMin = 80000000;
                    priceMin3.textContent = "8000";
                    break;
                case 11:
                    mmpMin = 90000000;
                    priceMin3.textContent = "9000";
                    break;
                case 12:
                    mmpMin = 100000000;
                    priceMin3.textContent = "1억";
                    break;
                case 13:
                    mmpMin = 150000000;
                    priceMin3.textContent = "1억 5000";
                    break;
                case 14:
                    mmpMin = 200000000;
                    priceMin3.textContent = "2억";
                    break;
                case 15:
                    mmpMin = 250000000;
                    priceMin3.textContent = "2억 5000";
                    break;
                case 16:
                    mmpMin = 300000000;
                    priceMin3.textContent = "3억";
                    break;
                case 17:
                    mmpMin = 350000000;
                    priceMin3.textContent = "3억 5000";
                    break;
                case 18:
                    mmpMin = 400000000;
                    priceMin3.textContent = "4억";
                    break;
                case 19:
                    mmpMin = 450000000;
                    priceMin3.textContent = "4억 5000";
                    break;
                case 20:
                    mmpMin = 500000000;
                    priceMin3.textContent = "5억";
                    break;
                case 21:
                    mmpMin = 700000000;
                    priceMin3.textContent = "7억";
                    break;
                case 22:
                    mmpMin = 1000000000;
                    priceMin3.textContent = "10억";
                    break;
                case 23:
                    mmpMin = 1500000000;
                    priceMin3.textContent = "15억";
                    break;
                case 24:
                    mmpMin = 2000000000;
                    priceMin3.textContent = "20억";
                    break;
            }
        }
        document.querySelector("input[name=deposit_min]").value = mmpMin;
    };

    function setRightValue3(e) {
        const target = e.target;
        const {value, min, max} = target;

        if (+value - +inputLeft3.value < 1) {
            target.value = +inputLeft3.value + 1;
        }

        const percent = (+target.value / 25) * 100;

        thumbRight3.style.right = (100 - percent) + "%";
        range3.style.right = (100 - percent) + "%";

        // 가격 변동 범위 설정
        if (+target.value === +max && +inputLeft3.value === +min) {
            priceMin3.textContent = "";
            mmp1.textContent = "전체";
            priceMax3.textContent = "";
            mmp2.textContent = "";
            mmpMax = "max";
        } 
        else {
            if (+inputLeft3.value === +min) {
                priceMin3.textContent = "";
                mmp1.textContent = "";
                mmp2.textContent = "까지";
            } 
            else {
                mmp1.textContent = " ~ ";
                mmp2.textContent = "";
            }
            switch (+target.value) {
                case 1:
                    mmpMax = 5000000;
                    priceMax3.textContent = "500";
                    break;
                case 2:
                    mmpMax = 7000000;
                    priceMax3.textContent = "700";
                    break;
                case 3:
                    mmpMax = 10000000;
                    priceMax3.textContent = "1000";
                    break;
                case 4:
                    mmpMax = 20000000;
                    priceMax3.textContent = "2000";
                    break;
                case 5:
                    mmpMax = 30000000;
                    priceMax3.textContent = "3000";
                    break;
                case 6:
                    mmpMax = 40000000;
                    priceMax3.textContent = "4000";
                    break;
                case 7:
                    mmpMax = 50000000;
                    priceMax3.textContent = "5000";
                    break;
                case 8:
                    mmpMax = 60000000;
                    priceMax3.textContent = "6000";
                    break;
                case 9:
                    mmpMax = 70000000;
                    priceMax3.textContent = "7000";
                    break;
                case 10:
                    mmpMax = 80000000;
                    priceMax3.textContent = "8000";
                    break;
                case 11:
                    mmpMax = 90000000;
                    priceMax3.textContent = "9000";
                    break;
                case 12:
                    mmpMax = 100000000;
                    priceMax3.textContent = "1억";
                    break;
                case 13:
                    mmpMax = 150000000;
                    priceMax3.textContent = "1억 5000";
                    break;
                case 14:
                    mmpMax = 200000000;
                    priceMax3.textContent = "2억";
                    break;
                case 15:
                    mmpMax = 250000000;
                    priceMax3.textContent = "2억 5000";
                    break;
                case 16:
                    mmpMax = 300000000;
                    priceMax3.textContent = "3억";
                    break;
                case 17:
                    mmpMax = 350000000;
                    priceMax3.textContent = "3억 5000";
                    break;
                case 18:
                    mmpMax = 400000000;
                    priceMax3.textContent = "4억";
                    break;
                case 19:
                    mmpMax = 450000000;
                    priceMax3.textContent = "4억 5000";
                    break;
                case 20:
                    mmpMax = 500000000;
                    priceMax3.textContent = "5억";
                    break;
                case 21:
                    mmpMax = 700000000;
                    priceMax3.textContent = "7억";
                    break;
                case 22:
                    mmpMax = 1000000000;
                    priceMax3.textContent = "10억";
                    break;
                case 23:
                    mmpMax = 1500000000;
                    priceMax3.textContent = "15억";
                    break;
                case 24:
                    mmpMax = 2000000000;
                    priceMax3.textContent = "20억";
                    break;
                case 25:
                    priceMax3.textContent = "";
                    mmp1.textContent = "부터";
                    mmp2.textContent = "";
                    mmpMax = "max";
                    break;
            }
        }
        document.querySelector("input[name=deposit_max]").value = mmpMax;
    };

    if (inputLeft3 && inputRight3) {
        inputLeft3.addEventListener("input", setLeftValue3);
        inputRight3.addEventListener("input", setRightValue3);
    }

    $("#filter-btn").click(function(){
        if($(this).hasClass("filter-open")){
            $(this).addClass("filter-close");
            $(this).removeClass("filter-open");
            $(".active").show();
            $(".list").hide();
            $(".listDetail").hide();
            $(this).parent().css("border-bottom","none");
            $(".total-list").hide();
        }
        else{
            $(this).removeClass("filter-close");
            $(this).addClass("filter-open");
            $(".active").hide();
            $(".list").show();
            $(".listDetail").hide();
            $(this).parent().css("border-bottom","1px solid lightgray");
            $(".total-list").show();
        }
    });
    
    $("#monthly").click(function(){
        if($(this).hasClass("choice") && !$("#charter").hasClass("choice")){
            alert("1개의 매물 종류가 선택되어야 합니다.");
        }
        else{
        	$(this).addClass("choice");
            $("#monthly-range").show();
            $("#deposit-range").show();
            inputLeft2.value = 0;
            inputRight2.value = 20;
            inputLeft3.value = 0;
            inputRight3.value = 25;
            thumbLeft2.style.left = "0%";
            range2.style.left = "0%";
            thumbRight2.style.right = "0%";
            range2.style.right = "0%";
            thumbLeft3.style.left = "0%";
            range3.style.left = "0%";
            thumbRight3.style.right = "0%";
            range3.style.right = "0%";
            priceMin2.textContent = "";
            mp1.textContent = "전체";
            priceMax2.textContent = "";
            mp2.textContent = "";
            priceMin3.textContent = "";
            mmp1.textContent = "전체";
            priceMax3.textContent = "";
            mmp2.textContent = "";
            document.querySelector("input[name=monthly_min]").value = "0";
            document.querySelector("input[name=monthly_max]").value = "max";
            document.querySelector("input[name=deposit_min]").value = "0";
            document.querySelector("input[name=deposit_max]").value = "max";
        	$("#charter").removeClass("choice");
            $("#charter-range").hide();
            document.querySelector("input[name=charter_min]").value = "N";
            document.querySelector("input[name=charter_max]").value = "N";
        }
    });

    $("#charter").click(function(){
        if($(this).hasClass("choice") && !$("#monthly").hasClass("choice")){
            alert("1개의 매물 종류가 선택되어야 합니다.");
        }
        else{
            $(this).addClass("choice");
            $("#charter-range").show();
            inputLeft1.value = 0;
            inputRight1.value = 25;
            thumbLeft1.style.left = "0%";
            range1.style.left = "0%";
            thumbRight1.style.right = "0%";
            range1.style.right = "0%";
            priceMin1.textContent = "";
            cp1.textContent = "전체";
            priceMax1.textContent = "";
            cp2.textContent = "";
            document.querySelector("input[name=charter_min]").value = "0";
            document.querySelector("input[name=charter_max]").value = "max";
            $("#monthly").removeClass("choice");
            $("#monthly-range").hide();
            $("#deposit-range").hide();
            document.querySelector("input[name=monthly_min]").value = "N";
            document.querySelector("input[name=monthly_max]").value = "N";
            document.querySelector("input[name=deposit_min]").value = "N";
            document.querySelector("input[name=deposit_max]").value = "N";
        }
    });

    $("#floor1").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=floor1]").val("N");
        }
        else{
            $(this).addClass("choice");
            $("input[name=floor1]").val($(this).val());
        }
    });
    $("#floor2").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=floor2]").val("N");
        }
        else{
            $(this).addClass("choice");
            $("input[name=floor2]").val($(this).val());
        }
    });
    $("#floor3").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=floor3]").val("N");
        }
        else{
            $(this).addClass("choice");
            $("input[name=floor3]").val($(this).val());
        }
    });
    $("#parking").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=parking]").val("0");
        }
        else{
            $(this).addClass("choice");
            $("input[name=parking]").val("1");
        }
    });
    $("#elevator").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=elevator]").val("0");
        }
        else{
            $(this).addClass("choice");
            $("input[name=elevator]").val("1");
        }
    });
    $("#animal").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=animal]").val("0");
        }
        else{
            $(this).addClass("choice");
            $("input[name=animal]").val("1");
        }
    });
    $("#loan").click(function(){
        if($(this).hasClass("choice")){
            $(this).removeClass("choice");
            $("input[name=loan]").val("0");
        }
        else{
            $(this).addClass("choice");
            $("input[name=loan]").val("1");
        }
    });

    $("#reset-btn").click(function(){
        document.querySelector("input[name=monthly_min]").value = "0";
        document.querySelector("input[name=monthly_max]").value = "max";
        document.querySelector("input[name=deposit_min]").value = "0";
        document.querySelector("input[name=deposit_max]").value = "max";
        document.querySelector("input[name=charter_min]").value = "N";
        document.querySelector("input[name=charter_max]").value = "N";
        inputLeft1.value = 0;
        inputRight1.value = 25;
        thumbLeft1.style.left = "0%";
        range1.style.left = "0%";
        thumbRight1.style.right = "0%";
        range1.style.right = "0%";
        priceMin1.textContent = "";
        cp1.textContent = "전체";
        priceMax1.textContent = "";
        cp2.textContent = "";
        inputLeft2.value = 0;
        inputRight2.value = 20;
        inputLeft3.value = 0;
        inputRight3.value = 25;
        thumbLeft2.style.left = "0%";
        range2.style.left = "0%";
        thumbRight2.style.right = "0%";
        range2.style.right = "0%";
        thumbLeft3.style.left = "0%";
        range3.style.left = "0%";
        thumbRight3.style.right = "0%";
        range3.style.right = "0%";
        priceMin2.textContent = "";
        mp1.textContent = "전체";
        priceMax2.textContent = "";
        mp2.textContent = "";
        priceMin3.textContent = "";
        mmp1.textContent = "전체";
        priceMax3.textContent = "";
        mmp2.textContent = "";
        $("input[name=floor1]").val("N");
        $("input[name=floor2]").val("N");
        $("input[name=floor3]").val("N");
        $("input[name=parking]").val("0");
        $("input[name=elevator]").val("0");
        $("input[name=animal]").val("0");
        $("input[name=loan]").val("0");
        if(!$("#monthly").hasClass("choice")){
            $("#monthly").addClass("choice");
        }
        if($("#charter").hasClass("choice")){
            $("#charter").removeClass("choice");
        }
        if($("#floor1").hasClass("choice")){
            $("#floor1").removeClass("choice");
        }
        if($("#floor2").hasClass("choice")){
            $("#floor2").removeClass("choice");
        }
        if($("#floor3").hasClass("choice")){
            $("#floor3").removeClass("choice");
        }
        if($("#parking").hasClass("choice")){
            $("#parking").removeClass("choice");
        }
        if($("#elevator").hasClass("choice")){
            $("#elevator").removeClass("choice");
        }
        if($("#animal").hasClass("choice")){
            $("#animal").removeClass("choice");
        }
        if($("#loan").hasClass("choice")){
            $("#loan").removeClass("choice");
        }
        $("#monthly-range").show();
        $("#deposit-range").show();
        $("#charter-range").hide();
    });

};