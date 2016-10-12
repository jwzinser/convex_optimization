function C=Contract(Tcon,Acon,j)
C=zeros(100,60);
for i=1:60
    C(:,i)=Tcon(i,j)*Acon(:,j);
end

