var x = -2147483648;
console.log("#10;x=${x};");
while (x <= 2147483647) {
  if (Math.abs(x) > 10 ** 9) {
    console.log(`#10;x=${x};`);
    x += 10 ** 6;
  } else {
    console.log(`#10;x=${x};`);
    x += 10**5;
  }
}
