; by sfufoet
; v 0.2
; �޸� win7 bug��by ��

#NoTrayIcon 
#SingleInstance force

GroupAdd, WinGroup, ahk_class Progman
GroupAdd, WinGroup, ahk_class WorkerW
GroupAdd, WinGroup2, ahk_class ExploreWClass
GroupAdd, WinGroup2, ahk_class CabinetWClass

; �� Everything ���ڴ��ڷǼ���״̬���Զ��ر�����by ỷ� http://yefoenix.ws/
#Persistent
	SetTimer,ClsEvthn,1000
return

ClsEvthn:
	IfWinExist,ahk_class EVERYTHING
	{
		IfWinNotActive,ahk_class EVERYTHING
		{
			WinClose,ahk_class EVERYTHING
			Return
		}
		else
		return
	}
	else
return
; �������

#f::
send #^+!P
return

#IfWinActive ahk_group WinGroup
; ˫�� Ctrl ���� Everything
;   * ��һ�ΰ��� LCtrl���� KeyWait ��ȡ�������룬��� 0.5 ���ڲ��ǰ� LCtrl �����
;   * ��� 0.5 ���ڰ��� LCtrl�����ٶ��ڶ�����������Ϊ LCtrl ���Ϳ�ݼ���
;   * ���ڶ���������Ϊ LCtrl �����
~LCtrl::
Keywait, LCtrl, , t0.5
if errorlevel = 1
return
else
Keywait, LCtrl, d, t0.1
if errorlevel = 0
{
	FilePath=%A_Desktop%
	send #^+!P
	WinWaitActive, Everything
	ControlSetText, Edit1, "%FilePath%"%A_space%, A
	sleep 150
	send {end}
}
return
; �������

^f::
	FilePath=%A_Desktop%
	send #^+!P
	WinWaitActive, Everything
	ControlSetText, Edit1, "%FilePath%"%A_space%, A
	sleep 150
	send {end}
return

#IfWinActive ahk_group WinGroup2
; ˫�� Ctrl ���� Everything
;   * ��һ�ΰ��� LCtrl���� KeyWait ��ȡ�������룬��� 0.5 ���ڲ��ǰ� LCtrl �����
;   * ��� 0.5 ���ڰ��� LCtrl�����ٶ��ڶ�����������Ϊ LCtrl ���Ϳ�ݼ���
;   * ���ڶ���������Ϊ LCtrl �����
~LCtrl::
Keywait, LCtrl, , t0.5
if errorlevel = 1
return
else
Keywait, LCtrl, d, t0.1
if errorlevel = 0
{
	ControlGetText, FilePath, ToolbarWindow322, A
	stringreplace, FilePath, FilePath, ��ַ:%A_space%, , All
	; msgbox, %FilePath%
	if FilePath=����
		FilePath=%A_Desktop%
	if FilePath=��\�ĵ�
		FilePath=%A_MyDocuments%
	if FilePath in �����ھ�,�������,����վ,�����, �������\���п��������
		return
	send #^+!P
	WinWaitActive, Everything
	ControlSetText, Edit1, "%FilePath%"%A_space%, A
	sleep 150
	send {end}
}
return
; �������

^f::
	ControlGetText, FilePath, ToolbarWindow322, A
	stringreplace, FilePath, FilePath, ��ַ:%A_space%, , All
	; msgbox, %FilePath%
	if FilePath=����
		FilePath=%A_Desktop%
	if FilePath=��\�ĵ�
		FilePath=%A_MyDocuments%
	if FilePath in �����ھ�,�������,����վ,�����, �������\���п��������
		return
	send #^+!P
	WinWaitActive, Everything
	ControlSetText, Edit1, "%FilePath%"%A_space%, A
	sleep 150
	send {end}
return
