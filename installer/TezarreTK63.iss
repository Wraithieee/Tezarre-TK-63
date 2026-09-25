; Tezarre TK-63 Desktop Companion - Inno Setup Script
; Generates: Tezarre-TK63-Setup.exe

#define AppName      "Tezarre TK-63"
#define AppVersion   "1.2.4"
#define AppPublisher "Tezarre Gaming"
#define AppExeName   "Tezarre-TK63.exe"
#define AppId        "{{A3F92C1D-7E4B-4F8A-9C2E-1D5B6F3A8E7C}"
#define SourceDir    ".."

[Setup]
AppId={#AppId}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} v{#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL=https://github.com/tezarre-gaming/Tezarre-TK63
AppSupportURL=https://github.com/tezarre-gaming/Tezarre-TK63/issues
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename=Tezarre-TK63-Setup
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
WizardStyle=modern
WizardSizePercent=120
DisableWelcomePage=no
LicenseFile={#SourceDir}\LICENSE
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=commandline dialog
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
UninstallDisplayName={#AppName}
UninstallDisplayIcon={app}\{#AppExeName}
CreateUninstallRegKey=yes
Uninstallable=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon";   Description: "Create a &desktop shortcut"
Name: "startmenuicon"; Description: "Create a &Start Menu shortcut"

[Files]
; Main executable
Source: "{#SourceDir}\Tezarre-TK63.exe";         DestDir: "{app}"; Flags: ignoreversion

; Electron / Chromium runtime
Source: "{#SourceDir}\chrome_100_percent.pak";   DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\chrome_200_percent.pak";   DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\resources.pak";            DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\icudtl.dat";               DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\snapshot_blob.bin";        DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\v8_context_snapshot.bin";  DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\version";                  DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\LICENSE";                  DestDir: "{app}"; Flags: ignoreversion

; Native DLLs
Source: "{#SourceDir}\d3dcompiler_47.dll";       DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\ffmpeg.dll";               DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\dxcompiler.dll";           DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\dxil.dll";                 DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\vk_swiftshader.dll";       DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\vk_swiftshader_icd.json";  DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceDir}\vulkan-1.dll";             DestDir: "{app}"; Flags: ignoreversion

; Locales
Source: "{#SourceDir}\locales\*";               DestDir: "{app}\locales"; Flags: ignoreversion recursesubdirs createallsubdirs

; App ASAR + native modules (node-hid)
Source: "{#SourceDir}\resources\app.asar";                        DestDir: "{app}\resources"; Flags: ignoreversion
Source: "{#SourceDir}\resources\app.asar.unpacked\*";             DestDir: "{app}\resources\app.asar.unpacked"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autodesktop}\{#AppName}";     Filename: "{app}\{#AppExeName}"; Tasks: desktopicon;   Comment: "Launch Tezarre TK-63 companion"
Name: "{group}\{#AppName}";           Filename: "{app}\{#AppExeName}"; Tasks: startmenuicon; Comment: "Launch Tezarre TK-63 companion"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\{#AppExeName}"; Description: "Launch {#AppName} now"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKCU; Subkey: "Software\{#AppPublisher}\{#AppName}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekey

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
