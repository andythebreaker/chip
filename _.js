// `define size_minus_1(x) (x-1)
// `define matrix_size_1 3
// `define matrix_size_2 5
// `define vector_size `matrix_size_1
const fs = require('fs');

var matrix_size_1 = 3;//100;
var matrix_size_2 = 5;//400;
var hedder_0 = '`define size_minus_1(x) (x-1)';
var hedder_1 = '`define matrix_size_1 ';
var hedder_2 = '`define matrix_size_2 ';
var hedder_3 = '`define vector_size `matrix_size_1';
var hedder_4 = hedder_0 + '\n' + hedder_1 + String(matrix_size_1) + '\n' + hedder_2 + String(matrix_size_2) + '\n' + hedder_3 + '\n';
var hedder_5 = `module matrix_times_vector_genED_M_${matrix_size_1}_${matrix_size_2}_V_${matrix_size_1} (`;
var hedder_6 = 'input logic signed [31:0] matrix[0:`size_minus_1(`matrix_size_1)][0:`size_minus_1(`matrix_size_2)],';
var hedder_7 = 'input logic signed [31:0] vector[0:`size_minus_1(`vector_size)],';
var hedder_8 = 'output logic signed [31:0] result[0:`size_minus_1(`matrix_size_2)]';
var hedder_9 = ');';
var hedder_10 = hedder_4 + '\n' + hedder_5 + '\n' + hedder_6 + '\n' + hedder_7 + '\n' + hedder_8 + '\n' + hedder_9 + '\n';
fs.appendFile(`matrix_times_vector_genED_M_${matrix_size_1}_${matrix_size_2}_V_${matrix_size_1}.sv`, hedder_10, (err) => {
    if (err) {
        console.error(err);
    } else {
        console.log('File appended successfully.');
    }
});
for (let index = 0; index < matrix_size_2; index++) {
    var tmp=`assign result[${index}] = `;
    for (let j = 0; j < matrix_size_1; j++) {
        tmp+=`matrix[${j}][${index}] * vector[${j}] ${j+1<matrix_size_1?'+':';\n'} `;
    }
    fs.appendFile(`matrix_times_vector_genED_M_${matrix_size_1}_${matrix_size_2}_V_${matrix_size_1}.sv`, tmp, (err) => {
        if (err) {
            console.error(err);
        } else {
            console.log('File appended successfully.');
        }
    });
}
fs.appendFile(`matrix_times_vector_genED_M_${matrix_size_1}_${matrix_size_2}_V_${matrix_size_1}.sv`, '\nendmodule\n', (err) => {
    if (err) {
        console.error(err);
    } else {
        console.log('File appended successfully.');
    }
});