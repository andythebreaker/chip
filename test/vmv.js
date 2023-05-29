var max = Number.MIN_VALUE;
var min = Number.MAX_VALUE;

for (let a = -10; a <= 10; a++) {
  for (let b = -1; b <= 1; b++) {
    let c = a * b;
    if (c > max) {
      max = c;
    }
    if (c < min) {
      min = c;
    }
  }
}

console.log(`Max: ${max}`);
console.log(`Min: ${min}`);
