# Set location of the background
$savelocation = "$env:USERPROFILE\Pictures\daily_background.jpg"
# Check if we have internet, extra protection over Scheduled Task
while (!(Test-Connection bing.com -quiet -count 1)){Start-Sleep -s 1}

# Check if bing image already exists and remove it (old image)
if (Test-Path $savelocation){Remove-Item $savelocation}

# Setup query to get bing image
$web = New-Object Net.WebClient
$imghighres = $web.DownloadString("http://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1").Split('<>')[20]
$imgurl = "http://www.bing.com" + $imghighres

# Download figure
$wc = New-Object Net.WebClient
$wc.DownloadFile($imgurl,$savelocation);

# Set-ItemProperty -path "HKCU:\Control Panel\Desktop\" -name WallPaper -value $savelocation
# rundll32.exe user32.dll, UpdatePerUserSystemParameters

Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public enum Style : int
   {
       Tile, Center, Stretch, NoChange
   }
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path, Wallpaper.Style style ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
         RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
         switch( style )
         {
            case Style.Stretch :
               key.SetValue(@"WallpaperStyle", "2") ; 
               key.SetValue(@"TileWallpaper", "0") ;
               break;
            case Style.Center :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "0") ; 
               break;
            case Style.Tile :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "1") ;
               break;
            case Style.NoChange :
               break;
         }
         key.Close();
      }
   }
}
"@

[Wallpaper.Setter]::SetWallpaper($savelocation, 2)
