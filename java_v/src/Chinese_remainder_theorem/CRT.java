package Chinese_remainder_theorem;

public class CRT {
    private static final int num = 3;
    private static final int[] m;
    private static int M;
    private static final int[] M_i = new int[num];

    private static final int[] t = new int[num];

    static {
        M = 1;

        m = new int[]{256, 257, 259};
        for (int i: m)
            M *= i;
        for (int i = 0; i < num; i++)
            M_i[i] = M / m[i];
        for (int i = 0; i < num; i++)
            t[i] = mod_inv(M_i[i], m[i]);
    }

    public static int gcd(int a, int b) {
        if (b==0) return a;
        return gcd(b,a%b);
    }

    public static int mod_inv(int a, int m)
    {
        int m0 = m, t, q;
        int x0 = 0, x1 = 1;

        if (m == 1)
            return 0;

        // Apply extended Euclid Algorithm
        while (a > 1) {
            // q is quotient
            q = a / m;

            t = m;

            // m is remainder now, process
            // same as euclid's algo
            m = a % m;
            a = t;

            t = x0;

            x0 = x1 - q * x0;

            x1 = t;
        }

        // Make x1 positive
        if (x1 < 0)
            x1 += m0;

        return x1;
    }


    public static long Find_Min_X(int[] a)
    {

        long result = 0;
        for (int i = 0; i < num; i++) {

            result += (long) a[i] * t[i] * M_i[i];
        }

        return result % M;
    }

    public static int[] inverse(long a) {
        int[] inv = new int[num];
        for (int i = 0; i < num; i++) {
            inv[i] = (int) a % m[i];
        }
        return inv;
    }

    public static void main(String[] args) {
        int[] test = {225, 225, 225};
        long c = Find_Min_X(test);
        int[] inv = inverse(c);

        System.out.println(c);
        for (int i: inv)
            System.out.println(i);
    }

}
