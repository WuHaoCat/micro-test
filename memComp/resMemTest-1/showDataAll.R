for (i in 1:8) {
  name<-sprintf("memTest_%d_0_0", i)
  seq00<-dealData(name, 0)
  par00<-dealData(name, 1)
  name<-sprintf("memTest_%d_1_0", i)
  seq10<-dealData(name, 0)
  par10<-dealData(name, 1)
  name<-sprintf("memTest_%d_0_1", i)
  seq01<-dealData(name, 0)
  par01<-dealData(name, 1)
  name<-sprintf("memTest_%d_1_1", i)
  seq11<-dealData(name, 0)
  par11<-dealData(name, 1)
  name<-sprintf("memTest_%d", i)
  showData(name,seq00,seq10,seq01,seq11,par00,par10,par01,par11)
}

speedUp<-matrix(nrow=9, ncol=8)
for (i in 1:8) {
  name<-sprintf("memTest_%d_0_0", i)
  seq00<-dealData(name, 0)
  par00<-dealData(name, 1)
  speedUp[,i]<-seq00$totalTime/par00$totalTime-1;
}
name<-sprintf("SmemTest_0_0", i)
showSpeedUp(name,speedUp);
for (i in 1:8) {
  name<-sprintf("memTest_%d_0_1", i)
  seq01<-dealData(name, 0)
  par01<-dealData(name, 1)
  speedUp[,i]<-seq01$totalTime/par01$totalTime-1;
}
name<-sprintf("SmemTest_0_1", i)
showSpeedUp(name,speedUp);
for (i in 1:8) {
  name<-sprintf("memTest_%d_1_0", i)
  seq10<-dealData(name, 0)
  par10<-dealData(name, 1)
  speedUp[,i]<-seq10$totalTime/par10$totalTime-1;
}
name<-sprintf("SmemTest_1_0", i)
showSpeedUp(name,speedUp);
for (i in 1:8) {
  name<-sprintf("memTest_%d_1_1", i)
  seq11<-dealData(name, 0)
  par11<-dealData(name, 1)
  speedUp[,i]<-seq11$totalTime/par11$totalTime-1;
}
name<-sprintf("SmemTest_1_1", i)
showSpeedUp(name,speedUp)