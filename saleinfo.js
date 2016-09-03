const monthNames = ["January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"];

const weekDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];


function outputTextForSale(saleInfo) {
    "use strict";
    const displayDateTime = new Date(saleInfo.displayDateTime.replace("T", " "));
    let dateI = "";

    if (displayDateTime < new Date()) {
        dateI = "NOW";
    } else {
        dateI = monthNames[displayDateTime.getMonth()].substring(0, 3).toUpperCase() + " " + displayDateTime.getDate();
    }
    return dateI + " - SEPT 6";
}

function outputTextForEvent(eventInfo) {
    "use strict";
    const startDateTime = new Date(eventInfo.startDateTime.replace("T", " "));

    return weekDays[startDateTime.getDay()].substring(0, 4).toUpperCase() + ", " + monthNames[startDateTime.getMonth()].substring(0, 3).toUpperCase() + " " + startDateTime.getDate();
}


function saleOrEventText(eventInfo) {
    "use strict";
    //const displayDateTime = new Date(eventInfo.displayDateTime.replace("T", " "));
    const startDateTime = new Date(eventInfo.startDateTime.replace("T", " "));
    const endDateTime = new Date(eventInfo.endDateTime.replace("T", " "));

    if (startDateTime.getTime() === endDateTime.getTime()) {
        return outputTextForEvent(eventInfo);
    } else {
        return outputTextForSale(eventInfo);
    }
}

// --- USAGE ---
// in html use something like:
// <p id="eventDate"></p>
// document.getElementById("eventDate").innerHTML = saleOrEventText(eventInfo);



// --- TESTS ---
//displayDateTime in the past
let event1Info = {
    "title": "Labor Day Sale",
    "displayDateTime": "2016-08-29T00:00",
    "startDateTime": "2016-08-31T00:00",
    "endDateTime": "2016-09-06T23:59"
};

//displayDateTime in the future
let event2Info = {
    "title": "X Day Sale",
    "displayDateTime": "2016-10-29T00:00",
    "startDateTime": "2016-08-31T00:00",
    "endDateTime": "2016-09-06T23:59"
};

//startDate and endDate are the same
let event3Info = {
    "title": "Party Day",
    "displayDateTime": "2016-10-29T00:00",
    "startDateTime": "2016-10-29T00:00",
    "endDateTime": "2016-10-29T00:00"
};


console.log(saleOrEventText(event1Info));

console.log(saleOrEventText(event2Info));

console.log(saleOrEventText(event3Info));
