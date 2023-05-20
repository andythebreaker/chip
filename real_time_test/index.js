const fs = require("fs");

const data = [];

const isEmpty = (str) => {
    return str === "" || str.trim() === "";
};

fs.readFile("rawdata6.txt", "utf8", (err, content) => {
    if (err) {
        console.error(err);
        return;
    }

    const lines = content.split("\n");

    for (const line of lines) {
        if (!isEmpty(line)) {
            const json = JSON.parse(`{"obj":${line}}`);
            data.push(json);
        }
    }

    //cuz 0~2 have [[]] so need remove one [] to be []
    var tmp;
    tmp = data[0].obj;
    data[0].obj = tmp[0];
    tmp = data[1].obj;
    data[1].obj = tmp[0];
    tmp = data[2].obj;
    data[2].obj = tmp[0];
    console.log(data);

    fs.appendFileSync(`tb.sv`, `
    //========== this a testbench driven by 6 data in a group from python gen txt =========
    module tb;
    `, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });

    fs.appendFileSync(`tb.sv`, `
    endmodule
    `, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
});
