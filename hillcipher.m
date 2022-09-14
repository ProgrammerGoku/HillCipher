clc;clear all;close all;
msg=input('enter the plaintext','s');
len=length(msg);
f=1;
while(f)
    key=input('enter the key','s');
    L=sqrt(length(key));
    K=reshape(abs(key)-97,[L,L])';
    d=mod(det(K),26);
    if(d&&(gcd(sym(d),26))==1)
        f=0;
    else
        fprintf('Inverse key doesnt exist enter valid key\n');
    end
end
p=0;
n=mod(len,L);
if(n~=0)
    for i=1:L-n
        msg=[msg 'z'];
        p=p+1;
    end
end
x=length(msg)/L;
M=reshape(abs(msg)-97,[L,x])';
r=size(M,1);
det=find(mod((1:25)*sym(d),26)==1);
adj=adjoint(sym(K));
inv=mod(double(adj)*det,26);

for i=1:r
    c_val(i,:)=mod(M(i,:)*K,26);
end
cipher=char(reshape(c_val',1,length(msg))+97);
disp(cipher(1:length(msg)-p));

for i=1:x
    d_val(i,:)=mod(c_val(i,:)*inv,26);
end
decipher=char(reshape(d_val',1,length(msg))+97);
disp(decipher(1:length(msg)-p));