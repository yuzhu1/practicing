ed <- function(x1,x2,y1,y2){
  d = sqrt((x1-x2)^2 + (y2-y1)^2)
  return(d)
}

ed(2,8,5,1)


odd <- function(num){
  if (num %% 2 != 0){
    print("the number is odd")}
  else{print("the number is even")}
}

odd(3)


i=0
while(i<10){
  print(paste("loop", i))
  i = i + 1
}


i=0
while(i>-1){
  print(paste("loop", i))
  i = i + 1
}