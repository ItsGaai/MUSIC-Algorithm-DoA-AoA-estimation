clear all
close all
derad = pi/180; %�Ƕ�->����
radeg = 180/pi; %����->�Ƕ�
twpi = 2*pi;
kelm = 8;       %��Ԫ����     
dd = 0.5;       %��Ԫ���       
d=0:dd:(kelm-1)*dd;     
iwave = 3;      %��Դ��             
theta = [15 28 60];  %���﷽��/�����ƽǶ�Ϊ15 28 60
%���������������ƽǶ������úõġ�ʵ��Ӧ���в�Ӧ���ǲ�֪���Ƕ�ȥ��������Ƕ�ô����������ɵ������A��
%ʵ�ʲ��ã����յ�����ֱ��ΪX(t)����ʽ���ǽ��������ݷֽ�ΪA*S+N�����Բ���Ҫ���ɵ������
%����ʸ������ȥ���ɡ����ǽ������߱�������ԣ�ʵ��������ֻҪ�������������Ҫ���ɵ���ʸ������Ϊ������Ҫģ�����߽��յ����źţ����Ի�����Ƕȡ�
snr = 10;            %�����
n = 500;             %���������߳�Ϊ������
A=exp(-1i*twpi*d.'*sin(theta*derad));    %��������,.'ת�ã�'����ת��
S=randn(iwave,n);    %��Դ�źţ���̬�ֲ��������
X=A*S;               %�����ź�
X1=awgn(X,snr,'measured');  %��Ӹ�˹������
Rxx=X1*X1'/n;        %����Э�������
% InvS=inv(Rxx);       %����
[EV,D]=eig(Rxx);     %����Rxx������ֵ��Ӧ�ĶԽ���D�������������ɵľ���EV
EVA=diag(D)';        %diag��ȡ����Խ���Ԫ��
[EVA,I]=sort(EVA);   %����ֵ��С��������sortֻ�ܴ�С��������
EVA=fliplr(EVA);     %����ֵ���ҷ�ת���Ӵ�С��
EV=fliplr(EV(:,I));  %��Ӧ������������

%����MUSIC�׺���
for iang = 1:361
        angle(iang)=(iang-181)/2;
        phim=derad*angle(iang);
        a=exp(-1i*twpi*d*sin(phim)).';
        L=iwave;    
        En=EV(:,L+1:kelm);     %�õ������ӿռ�
        SP(iang)=(a'*a)/(a'*En*En'*a);
end

%��ͼ
SP=abs(SP);
SPmax=max(SP);
SP=10*log10(SP/SPmax);
h=plot(angle,SP);
set(h,'Linewidth',2)
xlabel('angle (degree)')
ylabel('magnitude (dB)')
axis([-90 90 -60 0])
set(gca, 'XTick',(-90:10:90))
grid on  