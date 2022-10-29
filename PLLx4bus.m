function [sys,x0,str,ts] = PLLx4bus(t,x,u,flag)

% u(1): Uagrid
% u(2): Ubgrid
% u(3): Ucgrid

% u(4): DroopFreq  下垂频率
% u(5): 下垂电压
% u(6): 同步命令


%--------------------
%输出
%y(1): 同步标志
%y(2): 相位 
%y(3): 电压幅值


switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%

  case 2,
    sys=mdlUpdate(t,x,u);
  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);
  case {1, 4, 9}
    sys=[]; %mdlTerminate(t,x,u);
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 602;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 10;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed
sys = simsizes(sizes);
x0  = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 ];
str = [];
ts  = [1e-4 0];



function sys=mdlUpdate(t,x,u)

% Tsample=1e-4;%采样时间
%逆变器运行模式
% GridConnectedMode=0;%为0表示并网运行，1独立运行
% IslandMode=1;%为0表示并网运行，1独立运行
% InvRunModel=GridConnectedMode;%为0表示并网运行，1独立运行
% SyncCmd=u(6);%读取同步命令
% %根据运行模式跳转
% x(4)=1;
% SyncEnd=x(4);%读取同步完成标志
% if (SyncCmd==1)&&(SyncEnd==0)%%如果要求同步如果同步没有完成
%     %如果要求同步，则使用三相锁相环，同时电压使用电网电压给定  
% dqPLL=0;
% 
% %下面用三相dq锁相环
% %三相锁相环的任务是跟踪电网相位频率，并且判断锁相成功与否来置位锁相标志
% %需要输入的变量有电网三相电压
% % u(1): Uagrid
% % u(2): Ubgrid
% % u(3): Ucgrid
% %输出的变量有pllFlag GridPhase GridFreq
% %中间需要保存到状态变量的值有：dqPLLintegral dqPLLresult GridPhase GridPhaseIntegral
% %第一步 读取需要使用的状态变量
% GridPhase=x(2);%电网相位
% dqPLLintegral=x(131);
% GridPhaseIntegral=x(133);%读取角度值
% KIdqPLL=0;
% KPdqPLL=10;
% %第二步 计算电网无功电压分量  这里直接当做差值，所以取负值  
% Uagrid=u(1);
% Ubgrid=u(2);
% Ucgrid=u(3);
%     UqPLL=-2/3*(sin(GridPhase-pi/2)*Uagrid+sin(GridPhase-pi/2-2/3*pi)*Ubgrid+sin(GridPhase-pi/2+2/3*pi)*Ucgrid);
% %第三步 调节器 
% dqPLLintegral=dqPLLintegral+UqPLL*KIdqPLL;
% dqPLLresult=dqPLLintegral+UqPLL*KPdqPLL;
% %第四步 计算的结果加上100*pi的前馈值即为角频率omega
% dqPLLomega=dqPLLresult+100*pi;
% dqPLLFreq=dqPLLomega/(2*pi);
% %第五步 积分计算角度 theta=omega*t
% GridPhaseIntegral=GridPhaseIntegral+dqPLLomega*Tsample;
% 
% GridPhase=mod(GridPhaseIntegral,2*pi);
% GridPhaseIntegral=GridPhase;
% %第六步 保存结果
% x(2)=GridPhase;%电网相位
% x(131)=dqPLLintegral;
% x(133)=GridPhaseIntegral;%读取角度值
% x(134)=dqPLLFreq;
% %第七步 判断是否锁相成功
% %这里不做判断了，认为100次锁相以后即为锁相成功
% %使用x(3)计数
% x(3)=x(3)+1;
% if x(3)>10
%     SyncEnd=1;
%     x(4)=SyncEnd;
%     x(3)=0;
% end
% %pllFlag=1;%暂时就当是一直锁上的
% %--------------------------------------------------------------------------
% %保存相位
% x(2)=GridPhase;%保存相位
% UdPLL=2/3*(cos(GridPhase-pi/2)*Uagrid+cos(GridPhase-pi/2-2/3*pi)*Ubgrid+cos(GridPhase-pi/2+2/3*pi)*Ucgrid);
% x(5)=UdPLL;%保存电压幅值
% %-----------------------
% %计算逆变器控制角度
% PwmPhase=GridPhase;
% x(28)=PwmPhase;
% end
% %*****保存结果******
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %如果不用同步或者同步已经完成
% if SyncCmd==0 || ((SyncCmd==1)&&(SyncEnd==1))
        tau_d = 32;
        tau_dv = 16; 
  
        PwmPhase=u(6);  %rad
        thetastar = u(7)*pi/180;  %degree to rad
        Vstar = u(8)*391.87;  %V
%         Vstar = 391.87;  %V
        theta = u(9)*pi/180;  %degree to rad
%         E = u(10);
%         E = 391.87;
%         Omega = -1./tau_d.*((theta - thetastar) - 2*pi*(u(4)-60));
        Omega=2*pi*u(4);%u(4)是下垂频率
        DeltaT=1e-4;
%         ThetaDesire = mod(PwmPhase + 60*DeltaT,360);
        DeltaTheta=(Omega)*DeltaT;
%         DeltaTheta = DeltaTheta - 8*DeltaTheta/(1/60/1e-4);
	      PwmPhase=PwmPhase+DeltaTheta;
          PwmPhase=mod(PwmPhase,2*pi);
          x(28)=PwmPhase;
%           E = u(1)/cos(PwmPhase);
%            Vdot = -1./tau_dv.*((E - Vstar) - u(5));
%            x(5) = E + Vdot*DeltaT;
          x(5)=391.87*1 + u(5); %/(1/60/DeltaT);%计算幅值
%           x(5)=20.41e3*1 + u(5); %/(1/60/DeltaT);%计算幅值

% end
%**************************************************************************

sys(1:602)=x(1:602);



function sys=mdlOutputs(t,x,u)

sys(1)=x(28);%角度
sys(2)=x(5);%幅值
sys(3)=x(4);%锁相完成标志
% sys(4) = ThetaDesire;
