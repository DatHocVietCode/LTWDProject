using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;

namespace WPF_Market.ViewModel
{
    public static class SecureStringProcess
    {
        public static string ConvertToUnsecureString(SecureString secureString)
        {
            if (secureString == null)
                throw new ArgumentNullException(nameof(secureString));

            IntPtr unmanagedString = IntPtr.Zero;
            try
            {
                // Giải mã SecureString thành chuỗi không an toàn (plaintext)
                unmanagedString = Marshal.SecureStringToGlobalAllocUnicode(secureString);
                return Marshal.PtrToStringUni(unmanagedString);
            }
            finally
            {
                // Phải giải phóng bộ nhớ để tránh rò rỉ bộ nhớ
                Marshal.ZeroFreeGlobalAllocUnicode(unmanagedString);
            }
        }
        // Chuyển đổi chuỗi (string) thành SecureString
        public static SecureString ConvertToSecureString(string unsecureString)
        {
            if ((string.IsNullOrEmpty(unsecureString) || unsecureString.Length == 0))
                return null;
            SecureString secureString = new SecureString();
            foreach (char c in unsecureString)
            {
                secureString.AppendChar(c);
            }
            return secureString;
        }
    }
}
