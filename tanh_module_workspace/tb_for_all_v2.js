var x = -24*10**7;
console.log("#10;x=${x};");
while (x <= 24*10**7) {
  /*if (Math.abs(x) > 10 ** 9) {
    console.log(`#10;x=${x};`);
    x += 10 ** 6;
  } else {*/
    console.log(`#10;x=${x};`);
    x += 10 ** 4;
  /*}*/
}
