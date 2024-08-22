#define AppName "BetterSADX"
#define AppVersion "5.0"
#define Game "Sonic Adventure DX"
[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{94AED795-F3EB-4912-8EF0-99E4A9DE86AE}
AppName={#AppName}
AppVersion={#AppVersion}
DefaultDirName={code:GetDefaultDir}
DisableProgramGroupPage=yes
DirExistsWarning=no
DisableDirPage=no
AppendDefaultDirName=no
DisableReadyPage=yes
AlwaysShowDirOnReadyPage=yes
CloseApplications=yes
OutputBaseFilename={#AppName} {#AppVersion}
SetupIconFile=SADX.ico
WizardImageFile=SADX_Large.bmp
WizardImageStretch=no
WizardSmallImageFile=SADX_small.bmp
Compression=none
Uninstallable=no
PrivilegesRequired=admin

[Types]
Name: "full"; Description: "Complete Dreamcast Experience"
Name: "standard"; Description: "Enhanced Director's Cut Experience"

[Components]
Name: "base"; Description: "Minimum required files"; Types: full standard; Flags: fixed
Name: "standard"; Description: "Major Improvements"; Types: standard; Flags: fixed
Name: "full"; Description: "Dreamcast Conversion"; Types: full; Flags: fixed

[Code]
//Use SystemMetrics to get resolution
function GetSystemMetrics (nIndex: Integer): Integer;
external 'GetSystemMetrics@User32.dll stdcall setuponly';

Const
    SM_CXSCREEN = 0; // The enum-value for getting the width of the cient area for a full-screen window on the primary display monitor, in pixels.
    SM_CYSCREEN = 1; // The enum-value for getting the height of the client area for a full-screen window on the primary display monitor, in pixels.

var ProgressPage: TOutputProgressWizardPage;

procedure InitializeWizard;
begin
  ProgressPage := CreateOutputProgressPage('Finishing up...','');
end;

function GetDefaultDir(def: string): string;
var InstalledDir : string;
begin
    //Check 32bit registry
    if RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 71250',
     'InstallLocation', InstalledDir) then
    begin
    end
    else if RegQueryStringValue(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 71250',
     'InstallLocation', InstalledDir) then
    begin
    end
    //Check 64bit registry
    else if RegQueryStringValue(HKLM64, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 71250',
     'InstallLocation', InstalledDir) then
    begin
    end;
    Result := InstalledDir;    
end;

function NextButtonClick(PageId: Integer): Boolean;
begin
    Result := True;
    if (PageId = wpSelectDir) and (
    not FileExists(ExpandConstant('{app}\steam_api.dll'))
    or not FileExists(ExpandConstant('{app}\install.vdf'))
    ) then
    begin
        MsgBox('The BetterSADX patch installer was unable to locate your Steam copy of Sonic Adventure DX. Please uninstall the game and redownload it through your Steam client and try again. If this issue persists, report it in the discussions section in the BetterSADX steam group.', mbError, MB_OK);
        Result := False;
        exit;
    end;
    if (PageId = wpSelectDir) and (not FileExists(ExpandConstant('{app}\SoundData\VOICE_US\wma\0000.adx')) and not FileExists(ExpandConstant('{app}\system\sounddata\VOICE_US\wma\0000.adx')))
    then
    begin
        MsgBox('You are missing some required files from the Steam version of the game. Please uninstall and reinstall the game from Steam.', mbError, MB_OK);
        Result := False;
        exit;
    end
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
ErrorCode: Integer;
res_x: Integer;
res_y: Integer;
begin
  if CurStep = ssPostInstall then
  begin
      //Start Post Install
      ProgressPage.Show;
      ProgressPage.SetProgress(10, 100);

      //Move ADX Audio to the mod folder to save copying the WMA
      ProgressPage.SetText('Moving ADX Audio...', '');
      Exec('cmd.exe', ExpandConstant('/c MOVE /Y "{app}\SoundData\bgm\wma\*.adx" "{app}\system\sounddata\bgm\wma\"'), '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
      Exec('cmd.exe', ExpandConstant('/c MOVE /Y "{app}\SoundData\VOICE_JP\WMA\*.adx" "{app}\system\sounddata\VOICE_JP\wma\"'), '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
      Exec('cmd.exe', ExpandConstant('/c MOVE /Y "{app}\SoundData\VOICE_US\WMA\*.adx" "{app}\system\sounddata\VOICE_US\wma\"'), '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);   
      
      //Remove unneeded folders
      ProgressPage.SetText('Removing unneeded folders...', '');
      ProgressPage.SetProgress(25, 100);
            
      DelTree(ExpandConstant('{app}\DLC'), True, True, True);
      DelTree(ExpandConstant('{app}\Data'), True, True, True);
      DelTree(ExpandConstant('{app}\Font'), True, True, True);
      DelTree(ExpandConstant('{app}\linux32'), True, True, True);
      DelTree(ExpandConstant('{app}\linux64'), True, True, True);
      DelTree(ExpandConstant('{app}\osx32'), True, True, True);
      DelTree(ExpandConstant('{app}\Shader'), True, True, True);
      DelTree(ExpandConstant('{app}\SoundData'), True, True, True);
      DelTree(ExpandConstant('{app}\win64'), True, True, True);
      DelTree(ExpandConstant('{app}\system\BackGround'), True, True, True);
      DelTree(ExpandConstant('{app}\system\BigEndian'), True, True, True);
      DelTree(ExpandConstant('{app}\system\CreateNewFile'), True, True, True);
      DelTree(ExpandConstant('{app}\system\DC'), True, True, True);
      DelTree(ExpandConstant('{app}\system\Leaderboards'), True, True, True);
      DelTree(ExpandConstant('{app}\system\LittleEndian'), True, True, True);
      DelTree(ExpandConstant('{app}\system\Logo'), True, True, True);
      DelTree(ExpandConstant('{app}\system\NowLoading'), True, True, True);
      DelTree(ExpandConstant('{app}\system\Option'), True, True, True);
      DelTree(ExpandConstant('{app}\system\texture_repalce'), True, True, True);
      DelTree(ExpandConstant('{app}\system\Tips_DDS'), True, True, True);
      DelTree(ExpandConstant('{app}\system\tips_exit'), True, True, True);
      DelTree(ExpandConstant('{app}\system\TUTO'), True, True, True);
      DelTree(ExpandConstant('{app}\system\TUTO_Texture'), True, True, True);
      DelTree(ExpandConstant('{app}\system\Water'), True, True, True);
      
      ProgressPage.SetText('Installing redistributables...', ''); 
      ProgressPage.SetProgress(50, 100);
      //VC Redist 2013, 2015-2019
      Exec(ExpandConstant('{app}\_CommonRedist\vcredist\2013\vcredist_x86.exe'), '/quiet /norestart', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
      Exec(ExpandConstant('{app}\_CommonRedist\vcredist\2015-2019\VC_redist.x86.exe'), '/quiet /norestart', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
      //.NET Framework 4.0 and 4.5
      Exec(ExpandConstant('{app}\_CommonRedist\.NET Framework\dotNetFx40_Full_x86_x64.exe'), '/q /norestart', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
      Exec(ExpandConstant('{app}\_CommonRedist\.NET Framework\dotnetfx45_full_x86_x64.exe'), '/q /norestart', '', SW_SHOW, ewWaitUntilTerminated, ErrorCode);
      
      //Remove unneeded redist executables
      ProgressPage.SetText('Deleting redist installers...', '');
      ProgressPage.SetProgress(65, 100);
            
      DelTree(ExpandConstant('{app}\_CommonRedist'), True, True, True);
            
      //Add DEP exemption entry
      ProgressPage.SetText('Adding DEP exception...', '');
      ProgressPage.SetProgress(75, 100);
      Exec('rundll32.exe', ExpandConstant('sysdm.cpl, NoExecuteAddFileOptOutList "{app}\sonic.exe"'), '', SW_SHOW, ewNoWait, ErrorCode);
    
      //Copy Save Data
      ProgressPage.SetText('Copying Save data...', '');
      ProgressPage.SetProgress(90, 100);
      
      If (not DirExists(ExpandConstant('{app}\savedata\'))) Then begin
        If (DirExists(ExpandConstant('{userdocs}\SEGA\Sonic Adventure DX\savedata\'))) Then begin
          CreateDir(ExpandConstant('{app}\savedata\'));
          FileCopy(ExpandConstant('{userdocs}\SEGA\Sonic Adventure DX\SAVEDATA\SonicAdventureChaoGarden.snc'),ExpandConstant('{app}\savedata\SONICADVENTURE_DX_CHAOGARDEN.snc'),True);     
          Exec(ExpandConstant('{app}\SADXSteamSaveConverter.exe'), '', '', SW_HIDE, ewWaitUntilTerminated, ErrorCode);
          DeleteFile(ExpandConstant('{app}\SADXSteamSaveConverter.exe'));     
        end      
      end;

      if IsComponentSelected('standard') or IsComponentSelected('full') then
      begin
        res_x := GetSystemMetrics(SM_CXSCREEN);
        res_y := GetSystemMetrics(SM_CYSCREEN);
        SaveStringToFile(ExpandConstant('{app}\mods\SADXModLoader.ini'), #13#10 + 'HorizontalResolution=' + IntToStr(res_x) + #13#10 + 'VerticalResolution=' + IntToStr(res_y), True);
      end;

      //End Post Install
      ProgressPage.Hide;

  end;
end;

function InitializeSetup(): Boolean;
var wnGame: longint;
    classGame: longint;
    classLauncher: longint;
    strGame: string;
    strLauncher: string;
    errorRunning: string;
begin
strGame := 'Sonic Adventure DX';
strLauncher := 'Direct3DWindowClass';
wnGame := FindWindowByWindowName(strGame);
classGame := FindWindowByClassName(strGame);
classLauncher:= FindWindowByClassName(strLauncher);
errorRunning:= 'Please make sure {#Game} is not running and run the installer again.';    
  if classGame <> 0 then
    begin
    MsgBox(errorRunning,  mbInformation, MB_OK);
    end
  else if (classLauncher and wnGame <> 0) then
    begin
    MsgBox(errorRunning,  mbInformation, MB_OK);
    end
  else
    begin
      Result := true;
    end
    
end;

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Messages]
SetupAppTitle={#AppName} {#AppVersion}
SetupWindowTitle={#AppName} {#AppVersion} 
WelcomeLabel1={#AppName} {#AppVersion} 
WelcomeLabel2=Before continuing, please make sure that you have a clean install of the {#Game} Steam release.
SelectDirLabel3=Setup will detect where the Steam version of {#Game} has been installed.
SelectDirBrowseLabel=If it has not been detected, click Browse to specify the folder.
SelectComponentsLabel2=Select from the dropdown which edition of BetterSADX you want to install. Please refer to the BetterSADX guide for details on what each includes. Click Next when you are ready to continue.
FinishedHeadingLabel=Patch Complete

[InstallDelete]
Type: files; Name: "{app}\input_config.xml"
Type: files; Name: "{app}\keycap_config.xml"
Type: files; Name: "{app}\Sonic Adventure DX.exe"
Type: files; Name: "{app}\system_config.xml"
Type: files; Name: "{app}\system\AL_STG_KINDER_AD_TEX_R.pvm"
Type: files; Name: "{app}\system\AL_TEX_ODEKAKE_MENU_EN_R.pvm"
Type: files; Name: "{app}\system\AL_TEX_ODEKAKE_MENU_JP_R.pvm"
Type: files; Name: "{app}\system\AVA_DLG_F.pvm"
Type: files; Name: "{app}\system\AVA_DLG_G.pvm"
Type: files; Name: "{app}\system\AVA_DLG_I.pvm"
Type: files; Name: "{app}\system\AVA_DLG_S.pvm"
Type: files; Name: "{app}\system\AVA_FILESEL_F.pvm"
Type: files; Name: "{app}\system\AVA_FILESEL_G.pvm"
Type: files; Name: "{app}\system\AVA_FILESEL_I.pvm"
Type: files; Name: "{app}\system\AVA_FILESEL_S.pvm"
Type: files; Name: "{app}\system\AVA_GTITLE0_DC.pvm"
Type: files; Name: "{app}\system\AVA_GTITLE0_F.pvm"
Type: files; Name: "{app}\system\AVA_GTITLE0_G.pvm"
Type: files; Name: "{app}\system\AVA_GTITLE0_I.pvm"
Type: files; Name: "{app}\system\AVA_GTITLE0_S.pvm"
Type: files; Name: "{app}\system\AVA_SNDTEST_E_R.pvm"
Type: files; Name: "{app}\system\AVA_SNDTEST_R.pvm"
Type: files; Name: "{app}\system\AVA_TITLE_CMN2.pvm"
Type: files; Name: "{app}\system\AVA_TITLE_F.pvm"
Type: files; Name: "{app}\system\AVA_TITLE_G.pvm"
Type: files; Name: "{app}\system\AVA_TITLE_I.pvm"
Type: files; Name: "{app}\system\AVA_TITLE_S.pvm"
Type: files; Name: "{app}\system\AVA_VMSSEL_F.pvm"
Type: files; Name: "{app}\system\AVA_VMSSEL_G.pvm"
Type: files; Name: "{app}\system\AVA_VMSSEL_I.pvm"
Type: files; Name: "{app}\system\AVA_VMSSEL_S.pvm"
Type: files; Name: "{app}\system\CON_REGULAR_F.pvm"
Type: files; Name: "{app}\system\CON_REGULAR_G.pvm"
Type: files; Name: "{app}\system\CON_REGULAR_I.pvm"
Type: files; Name: "{app}\system\CON_REGULAR_S.pvm"
Type: files; Name: "{app}\system\DC_HELP_OPTIONS_F.pvm"
Type: files; Name: "{app}\system\DC_HELP_OPTIONS_G.pvm"
Type: files; Name: "{app}\system\DC_HELP_OPTIONS_I.pvm"
Type: files; Name: "{app}\system\DC_HELP_OPTIONS_J.pvm"
Type: files; Name: "{app}\system\DC_HELP_OPTIONS_S.pvm"
Type: files; Name: "{app}\system\DC_HOW_PLAY_F.pvm"
Type: files; Name: "{app}\system\DC_HOW_PLAY_G.pvm"
Type: files; Name: "{app}\system\DC_HOW_PLAY_I.pvm"
Type: files; Name: "{app}\system\DC_HOW_PLAY_J.pvm"
Type: files; Name: "{app}\system\DC_HOW_PLAY_S.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU_F.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU_G.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU_I.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU_J.pvm"
Type: files; Name: "{app}\system\DC_LEADER_MENU_S.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU_F.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU_G.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU_I.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU_J.pvm"
Type: files; Name: "{app}\system\DC_MAIN_MENU_S.pvm"
Type: files; Name: "{app}\system\GAMEOVER_F.pvm"
Type: files; Name: "{app}\system\GAMEOVER_G.pvm"
Type: files; Name: "{app}\system\GAMEOVER_I.pvm"
Type: files; Name: "{app}\system\GAMEOVER_S.pvm"
Type: files; Name: "{app}\system\MAP_EC_A_R.pvm"
Type: files; Name: "{app}\system\MAP_EC_B_R.pvm"
Type: files; Name: "{app}\system\MAP_EC_H_R.pvm"
Type: files; Name: "{app}\system\MAP_MR_A_R.pvm"
Type: files; Name: "{app}\system\MAP_MR_J_R.pvm"
Type: files; Name: "{app}\system\MAP_MR_S_R.pvm"
Type: files; Name: "{app}\system\MAP_PAST_E_R.pvm"
Type: files; Name: "{app}\system\MAP_PAST_S_R.pvm"
Type: files; Name: "{app}\system\MAP_SS_R.pvm"
Type: files; Name: "{app}\system\MIS_C_EN_R.pvm"
Type: files; Name: "{app}\system\MIS_C_J_R.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC_F.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC_G.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC_I.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC_J.pvm"
Type: files; Name: "{app}\system\PRESSSTART_DC_S.pvm"
Type: files; Name: "{app}\system\PRESSSTART_F.pvm"
Type: files; Name: "{app}\system\PRESSSTART_G.pvm"
Type: files; Name: "{app}\system\PRESSSTART_I.pvm"
Type: files; Name: "{app}\system\PRESSSTART_J.pvm"
Type: files; Name: "{app}\system\PRESSSTART_S.pvm"
Type: files; Name: "{app}\system\SA1.SFD"
Type: files; Name: "{app}\system\SA2.SFD"
Type: files; Name: "{app}\system\SA3.SFD"
Type: files; Name: "{app}\system\SA4.SFD"
Type: files; Name: "{app}\system\SA5.SFD"
Type: files; Name: "{app}\system\SA6.SFD"
Type: files; Name: "{app}\system\SA7.SFD"
Type: files; Name: "{app}\system\SA8.SFD"
Type: files; Name: "{app}\system\TUTO_CMN_E_R.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_F.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_F_R.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_G.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_G_R.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_I.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_I_R.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_R.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_S.pvm"
Type: files; Name: "{app}\system\TUTO_CMN_S_R.pvm"
Type: files; Name: "{app}\system\ava_LB_MENU.pvm"
Type: files; Name: "{app}\system\ava_help_options.pvm"
Type: files; Name: "{app}\system\ava_how2play.pvm"
Type: files; Name: "{app}\system\ava_tool_tips.pvm"

;Remove for non-Dreamcast installs. Other installs will re-add this.
Type: files; Name: "{app}\d3d8.dll"

[Files]
; Files
Source: ".\Install_Steam\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: base
Source: ".\Install_Shared\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: base
Source: ".\Install_Mods_Standard\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: standard
Source: ".\Install_Mods_Common\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: full standard
Source: ".\Install_Mods_DC\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: full
; Configs
Source: ".\Config_Standard\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: standard
Source: ".\Config_DC\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: full
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKLM64; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\sonic.exe"; ValueData: "HIGHDPIAWARE "; Check: IsWin64
Root: HKLM32; Subkey: "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"; ValueType: string; ValueName: "{app}\sonic.exe"; ValueData: "HIGHDPIAWARE "; Check: Not IsWin64

[Run]
Filename: "steam://openurl/https://steamcommunity.com/groups/BetterSADX"; Description: "Open BetterSADX Steam group"; Flags: shellexec runasoriginaluser postinstall nowait