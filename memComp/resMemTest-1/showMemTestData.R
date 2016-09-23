dealData<-function(memTestName, par){
  memTestRes<-sprintf("%s.txt", memTestName) 
  dN<-read.csv(memTestRes, sep=",")
  dN$start1<-dN$start1/1000000
  dN$start2<-dN$start2/1000000
  dN$end1<-dN$end1/1000000
  dN$end2<-dN$end2/1000000
  
  dNSeq<-dN[which(dN$Par==par),]
  rangeSizeS<-range(dNSeq$Size)
  dNSeq<-dNSeq[,c(2:6)]
  rowNum<-length(dNSeq$Size)
  totalTS<-1:rowNum
  for (i in 1:rowNum){
    totalTS[i]<-max(dNSeq[i,c("start1","end1","start2","end2")])
  }
  dNSeqTime<-data.frame(dNSeq$Size, totalTS)
  totalSize<-rangeSizeS[1]:rangeSizeS[2]
  totalTime<-rangeSizeS[1]:rangeSizeS[2]
  for (i in totalSize) {
    tmp<-dNSeqTime[which(dNSeqTime$dNSeq.Size==i),]
    totalTime[i]<-mean(tmp$totalTS)
  }
  return(data.frame(totalSize, totalTime))
}

showData<-function(memTestName, seq00,seq10,seq01,seq11,par00,par10,par01,par11){
  pictureName<-sprintf("%s.pdf", memTestName) 
  pdf(pictureName)
  xrange<-range(seq00$totalSize)
  yrange<-range(seq00$totalTime,seq10$totalTime,seq01$totalTime,seq11$totalTime,par00$totalTime,par10$totalTime,par01$totalTime,par11$totalTime)
  plot(xrange,yrange,type="n", xlab="Size", ylab = "TimeCost(ms)", xaxt = "n")
  xTick<- seq(from=xrange[1], to=xrange[2], by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(4)
  points(seq00$totalSize, seq00$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[1], cex = 0.5)
  points(seq01$totalSize, seq01$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[2], cex = 0.5)
  points(seq10$totalSize, seq10$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[3], cex = 0.5)
  points(seq11$totalSize, seq11$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[4], cex = 0.5)
  points(par00$totalSize, par00$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[1], cex = 0.5)
  points(par01$totalSize, par01$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[2], cex = 0.5)
  points(par10$totalSize, par10$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[3], cex = 0.5)
  points(par11$totalSize, par11$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[4], cex = 0.5)
  dev.off()
  
  pictureName<-sprintf("%s_1_1.pdf", memTestName) 
  pdf(pictureName)
  plot(xrange,yrange,type="n", xlab="Size", ylab = "TimeCost(ms)", xaxt = "n")
  xTick<- seq(from=xrange[1], to=xrange[2], by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(4)
  points(seq11$totalSize, seq11$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[4], cex = 0.5)
  points(par11$totalSize, par11$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[4], cex = 0.5)
  dev.off()
  
  pictureName<-sprintf("%s_0_1.pdf", memTestName) 
  pdf(pictureName)
  plot(xrange,yrange,type="n", xlab="Size", ylab = "TimeCost(ms)", xaxt = "n")
  xTick<- seq(from=xrange[1], to=xrange[2], by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(4)
  points(seq01$totalSize, seq01$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[2], cex = 0.5)
  points(par01$totalSize, par01$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[2], cex = 0.5)
  dev.off()
  
  pictureName<-sprintf("%s_0_0.pdf", memTestName) 
  pdf(pictureName)
  plot(xrange,yrange,type="n", xlab="Size", ylab = "TimeCost(ms)", xaxt = "n")
  xTick<- seq(from=xrange[1], to=xrange[2], by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(4)
  points(seq00$totalSize, seq00$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[1], cex = 0.5)
  points(par00$totalSize, par00$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[1], cex = 0.5)
  dev.off()
  
  pictureName<-sprintf("%s_1_0.pdf", memTestName) 
  pdf(pictureName)
  plot(xrange,yrange,type="n", xlab="Size", ylab = "TimeCost(ms)", xaxt = "n")
  xTick<- seq(from=xrange[1], to=xrange[2], by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(4)
  points(seq10$totalSize, seq10$totalTime, type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[3], cex = 0.5)
  points(par10$totalSize, par10$totalTime, type = "o", xaxt = "n", pch = 2, lty = 2, col = mcolors[3], cex = 0.5)
  dev.off()
}

showSpeedUp<-function(fileName, speedUp){
  rangeY<-range(speedUp[,1])
  for (i in 2:8) {
    rangeY<-range(rangeY, speedUp[,i])
  }
  fileName<-sprintf("%s.pdf", fileName);
  pdf(fileName)
  plot(c(1,8), rangeY,type="n", xlab="Size", ylab = "SpeedUp", xaxt = "n")
  xTick<- seq(from=1, to=9, by = 1)
  axis(1, at=xTick)
  mcolors <- rainbow(8)
  for (i in 1:8){
    points(1:9, speedUp[,i], type = "o", xaxt = "n", pch = 1, lty = 1, col = mcolors[i], cex = 0.5)
  }
  legend("topright", legend = c(1:8), cex = 0.8, xjust = 1, lty=rep(1, times = 8), pch==rep(1, times = 8),col=mcolors, bty="n")
  dev.off()
}