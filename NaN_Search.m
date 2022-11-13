function  [NaN]=NaN_Search(data)
%%  initialize
if nargin==0
   clc;
   clear all; 
   close all;
   load data data 
   load t t;
   load X X;
   load Y Y;
   load tx tx;
   load ty ty;
   load a a;
   load b b;
   data=X;
   t=Y;
   %% plot
   cols={'g','b'};
%    figure(1)
   for i=1:length(unique(t))
       pos=[];
       pos=find(i==t);
       hold on
       plot(data(pos,1),data(pos,2),'*','color',cols{i},'markersize',3);
    end
end
%
%% Search RNN  By  NaN_search
%% initialize paramters
n=size(data,1);
r=1;
tag=1;
NaN=cell(n,1)';
RN=zeros(n,1);
LB=cell(n,1);
Nb=zeros(n,1);
%%
kdtree=KDTreeSearcher(data,'bucketsize',1); 
index = knnsearch(kdtree,data,'k',n);
index(:,1)=[];
while tag
    %KNN_idx=knnsearch(data,data,'NSMethod','kdtree','K',r+1);
    KNN_idx=index(:,r);
    %% 计算RNN
    
    for i=1:n
        Nb(KNN_idx(i))=Nb(KNN_idx(i))+1;
        NaN{KNN_idx(i)}=[NaN{KNN_idx(i)},i];
    end
    pos=[];
    for i=1:n
        if length(NaN{i})~=0  %样本有RNN
           pos=[pos;i];
        end
    end
    RN(pos)=1;
    cnt(r)=length(find(RN==0));
    if r>2 && cnt(r)==cnt(r-1)
       tag=0;
       r=r-1;
    end
    r=r+1;
    
end
KNN=[];
KNN=index(:,1:1:r);
for i=1:n
    tempMat=NaN{i};
    Nb(i)=length(tempMat);
end
%Nb=(Nb-min(Nb))/(max(Nb)-min(Nb));
end