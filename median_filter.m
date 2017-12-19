function d=median_filter(x,n)       
[height, width]=size(x);     
x1=double(x);    
x2=x1;    
for i=1:height-n+1    
    for j=1:height-n+1    
        c=x1(i:i+(n-1),j:j+(n-1));     
        e=c(1,:);         
        for u=2:n    
            e=[e,c(u,:)];       
        end    
        mm=median(e);         
        x2(i+(n-1)/2,j+(n-1)/2)=mm;   
    end    
end     
d=uint8(x2); 