library(data.table)




FindPossiblePaths(1,1,2,2,8)

FindPossiblePaths <- function(XStart,YStart,XDest,YDest,n)
{
  # check if coordinate range is correct
  if(XStart<0 | XStart>n |YStart<0 | YStart>n )
  {
    return(print(paste("Start COrdinates Should be between 1 to",n)))
  }
  
  # check if coordinate range is correct
  if(XDest<0 | XDest>n |YDest<0 | YDest>n )
  {
    return(print(paste("Destination COrdinates Should be between 1 to",n)))
  }
  
  # Define list to hold next moves:
  # LinkedSource holds the source row number for the position
  NextSteps <<- data.table(X=XStart,Y=YStart,LinkedSource=0)
  
  # define list to hold destination paths found
  # LinkedSource holds the source row number for the source coordinates from
  # NextSteps list
  DestinationPaths <<-  data.table(PathID=0,LinkedSource=0)
  
  # initialize row counter for NextSteps List
  i <<- 1
  
  # initialize path counter for DestinationPaths list
  iPath <<- 0
  
  
  # iterate while there are rows in NextSteps list
  while(i < nrow(NextSteps)+1)
  {
    # Add next possible moves based on current row coordinates
    NextPos(NextSteps[,.SD[i]]$X,NextSteps[,.SD[i]]$Y,XDest,YDest,XStart,YStart)
    
    # increment row counter
    i <<-i+1
    
    # if loop has been run more than 10000 times then take hard break
    if(i>1000)
    {
      
      break
    }
    
    # if 10 destination paths have been found then stop loop
    if(nrow(DestinationPaths)>10)
    {
      break
    }
    
  }
  
  if(nrow(DestinationPaths)==1)
  {
    print("No path found")
  }
  else
  {
    DestinationPaths <<-DestinationPaths[,.SD[2:11]]
    
    for(k in 1:nrow(DestinationPaths))
    {
      # print paths found
      lpath <<-list(paste("x=",XDest,"y=",YDest))
      
      iPrintPaths <<- 1
      
      # call function to print path
      getPath(DestinationPaths[,.SD[k]]$LinkedSource)
    }
    
  }
  
}

#' This function calculates next moves based on input coordinates and eqation for next possible moves
#' call UpdateList funtion to update NextSteps list or DestinationPaths list.
#' 
#' @param x: x coordinate.
#' @param y: y coordinate.
NextPos <- function(x,y,XDest,YDest,XStart,YStart)
{
  if((x+1)<9 & (y+2)<9)
  {
    UpdateList(x+1,y+2,XDest,YDest,XStart,YStart)
  }
  
  if((x+1)<9 & (y-2)>0)
  {
    UpdateList(x+1,y-2,XDest,YDest,XStart,YStart)
  }
  
  if((x-1)>0 & (y+2)<9)
  {
    UpdateList(x-1,y+2,XDest,YDest,XStart,YStart)
  }
  
  if((x-1)>0 & (y-2)>0)
  {
    UpdateList(x-1,y-2,XDest,YDest,XStart,YStart)
  }
  
  if((x+2)<9 & (y+1)<9)
  {
    UpdateList(x+2,y+1,XDest,YDest,XStart,YStart)
  }
  
  if((x+2)<9 & (y-1)>0)
  {
    UpdateList(x+2,y-1,XDest,YDest,XStart,YStart)
  }
  
  if((x-2)>0 & (y+1)<9)
  {
    UpdateList(x-2,y+1,XDest,YDest,XStart,YStart)
  }
  
  if((x-2)>0 & (y-1)>0)
  {
    UpdateList(x-2,y-1,XDest,YDest,XStart,YStart)
  }
  
}



#' This function performs updates to the destination path list or
#' next steps list based on the input coordinates x,y. If the coordinates match destination
#' coordinates then DestinationPaths is updated else NextSteps is updated.
#' 
#' @param x: x coordinate.
#' @param y: y coordinate.
UpdateList <- function(x,y,XDest,YDest,XStart,YStart)
{
  if(!((XStart==x)& (YStart==y)))
  {
    if(i>1)
    {
      j<- NextSteps[,.SD[i]]$LinkedSource
      
      Xlb <- NextSteps[,.SD[j]]$X
      Ylb <- NextSteps[,.SD[j]]$Y
    }
    else
    {
      Xlb <-0
      Ylb <-0
    }
    
    if(!((Xlb==x)& (Ylb==y))){
    
    # if the destination coordinates are matched
    if((XDest==x)& (YDest==y))
    {
      # increment number of paths found by 1
      iPath <<- iPath+1
      
      #create path vector containing path number and linked row with NextSteps
      paths <- c(iPath,i)
      
      # update destination path list
      DestinationPaths <<- rbindlist(list(DestinationPaths,as.list(paths)))
      
    }
    else
    {
      NextSteps <<- rbindlist(list(NextSteps,as.list(c(x,y,i))))
    }
    }
  }
  
}


getPath <- function(linkedRow)
{
  if(linkedRow > 0)
  {
    iPrintPaths <<- iPrintPaths+1
    
    lpath[iPrintPaths] <<- paste("x=",NextSteps[,.SD[linkedRow]]$X,"and y=",NextSteps[,.SD[linkedRow]]$Y)
    
    
    
    #print(NextSteps[,.SD[linkedRow]]$LinkedSource)
    
    getPath(NextSteps[,.SD[linkedRow]]$LinkedSource)
  }
  else
  {
    
    lpath[iPrintPaths] <<-  paste("x=",NextSteps[,.SD[1]]$X,"and y=",NextSteps[,.SD[1]]$Y)
    
    #print("path completed")
    
    print(paste(rev(unlist(lpath))))
  }
  
}

