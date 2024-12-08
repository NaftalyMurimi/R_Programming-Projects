a <- c(1:10,1)
for(x in a){
  if(x%%2==0){
    y <- y +2 *x
    print(y)
    next
  }
  if(x%%2 !=0){
    y<- x^3
    print(y)
  }
}