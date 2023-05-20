// Author: andythebreaker
// Date: 2023-05-20
// Function: read in data from python gen txt (rawdata6.txt) and make tb.sv

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

    tmp = '`include "vmvmb.sv"\n';
    fs.appendFileSync(`tb.sv`, tmp + `
    //========== this a testbench driven by 6 data in a group from python gen txt =========
    module tb;
    logic signed [31:0] x[0:${data[0].obj.length - 1}];
    logic signed [31:0] Wx[0:${data[3].obj.length - 1}][0:${data[3].obj[0].length - 1}];
    logic signed [31:0] h_prev[0:${data[1].obj.length - 1}];
    logic signed [31:0] Wh[0:${data[4].obj.length - 1}][0:${data[4].obj[0].length - 1}];
    logic signed [31:0] b[0:${data[5].obj.length - 1}];
    logic signed [31:0] A[0:${data[5].obj.length - 1}];
    vmvmb dut(
        x,Wx,h_prev,Wh,b,A
    );
    initial begin
        $fsdbDumpfile("tb_6data.fsdb");
        $fsdbDumpvars("+all");
    end
    initial begin
    #10;
    x='{`, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });

    //insert x
    tmp = '';
    data[0].obj.forEach((element, index) => {
        tmp += `32'd${element}`;

        if (index === data[0].obj.length - 1) {
            tmp += '}';
        } else {
            tmp += ',';
        }
    });
    //do it's fs
    fs.appendFileSync(`tb.sv`, tmp + ';' + `
    h_prev='{`, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
    //insert h_prev
    tmp = '';
    data[1].obj.forEach((element, index) => {
        tmp += `32'd${element}`;

        if (index === data[1].obj.length - 1) {
            tmp += '}';
        } else {
            tmp += ',';
        }
    });
    //do it's fs
    fs.appendFileSync(`tb.sv`, tmp + ';' + `
    b='{`, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
    //insert b
    tmp = '';
    data[5].obj.forEach((element, index) => {
        tmp += `32'd${element}`;

        if (index === data[5].obj.length - 1) {
            tmp += '}';
        } else {
            tmp += ',';
        }
    });
    //do it's fs
    fs.appendFileSync(`tb.sv`, tmp + ';' + `
    Wx[0]='{`, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
    //insert Wx
    data[3].obj.forEach((element, index) => {
        tmp = '';
        element.forEach((ele, ix) => {
            tmp += `32'd${ele}`;

            if (ix === data[3].obj[index].length - 1) {
                tmp += '}';
            } else {
                tmp += ',';
            }
        });
        fs.appendFileSync(`tb.sv`, tmp + ';' + ((index === data[3].obj.length - 1)?"\nWh[0]='{":`
    Wx[${index + 1}]='{`), (err) => {
            if (err) {
                console.error(err);
            } else {
                console.log('File appended successfully.');
            }
        });
    });
    //insert Wh
    data[4].obj.forEach((element, index) => {
        tmp = '';
        element.forEach((ele, ix) => {
            tmp += `32'd${ele}`;

            if (ix === data[4].obj[index].length - 1) {
                tmp += '}';
            } else {
                tmp += ',';
            }
        });
        fs.appendFileSync(`tb.sv`, tmp + ';' + ((index === data[4].obj.length - 1)?"\n":`
    Wh[${index + 1}]='{`), (err) => {
            if (err) {
                console.error(err);
            } else {
                console.log('File appended successfully.');
            }
        });
    });

    fs.appendFileSync(`tb.sv`, `
    #10$display("EOF");
    #10$finish;
    end
    endmodule
    `, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
});
