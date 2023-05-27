const startPoint = -2147483648.0;
const endPoint = 2147483647.0;
const numPoints = 10000.0;

const logspacePoints = [];
const logStart = Math.log10(startPoint);
const logEnd = Math.log10(endPoint);
const step = (logEnd - logStart) / (numPoints - 1);

for (let i = 0; i < numPoints; i++) {
  const logValue = logStart + i * step;
  const value = Math.pow(10, logValue);
  logspacePoints.push(value);
}

// Print the points
for (let i = 0; i < logspacePoints.length; i++) {
  console.log(`#10;x=${logspacePoints[i]};`);
}
