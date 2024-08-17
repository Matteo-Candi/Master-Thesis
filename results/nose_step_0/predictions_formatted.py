# 1 
def greatestCommonDivisor(a, b):
    if a == 0 or b == 0:
        return a + b
    if a == b:
        return a
    if a > b:
        return greatestCommonDivisor(a % b, b)
    else:
        return greatestCommonDivisor(a, b % a)

# 2 
def largest_divisor(n):
    for i in range(2, n + 1):
        if n % i == 0:
            return n // i
    return 1

# 3 
def is_prime(n):
    if n < 2:
        return False
    for k in range(2, n):
        if n % k == 0:
            return False
    return True

# 4 
def fizzBuzz(n):
    count = 0
    for i in range(1, n):
        if i % 11 == 0 or i % 13 == 0:
            q = i
            while q > 0:
                if q % 10 == 7:
                    count += 1
                q //= 10
    return count

# 5 
def primeFib(n):
    f0 = 0
    f1 = 1
    while n > 0:
        p = f0 + f1
        is_prime = p >= 2
        for i in range(2, p):
            if p % i == 0:
                is_prime = False
                break
        if is_prime:
            n -= 1
        f0 = f1
        f1 = p
    return f1

# 6 
def triangle_area(a, h):
    return 0.5 * a * h

# 7 
def modP(n, p):
    ret = 1
    for i in range(n):
        ret = (ret * 2) % p
    return ret

# 8 
def add(x, y):
    return x + y

# 9 
def fib(n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib(n - 1) + fib(n - 2)

# 10 
def largest_prime_factor(n):
    i = 2
    while i * i <= n:
        if n % i:
            i += 1
        else:
            n //= i
    return n

# 11 
def sum_to_n(n):
    result = 0
    for i in range(1, n+1):
        result += i
    return result

# 12 
def fibfib(n):
    if n == 0:
        return 0
    if n == 1:
        return 0
    if n == 2:
        return 1
    return fibfib(n - 1) + fibfib(n - 2) + fibfib(n - 3)

# 13 
def is_multiply_prime(a):
    num = 0
    for i in range(2, a + 1):
        while a % i == 0:
            a /= i
            num += 1
    return num == 3

# 14 
def isSimplePower(x, n):
    if n == 1:
        return x == 1
    power = 1
    while power < x:
        power *= n
    return power == x

# 15 
def choose_num(x, y):
    if x > y:
        return -1
    if y % 2 == 0:
        return y
    if x == y:
        return -1
    return y - 1

# 16 
def isEqualToSumEven(n):
    return n % 2 == 0 and n >= 8

# 17 
def special_factorial(n):
    fact = 1
    special_fact = 1
    for i in range(1, n+1):
        fact *= i
        special_fact *= fact
    return special_fact

# 18 
def xOrY(n, x, y):
    is_prime = n >= 2
    for i in range(2, n):
        if n % i == 0:
            is_prime = False
            break
    if is_prime:
        return x
    return y

# 19 
def rightAngleTriangle(a, b, c):
    return a * a == b * b + c * c or b * b == a * a + c * c or c * c == a * a + b * b

# 20 
def fast_pow(n, k):
    if k == 0:
        return 1
    temp = fast_pow(n, k // 2)
    if k % 2 == 0:
        return temp * temp
    else:
        return n * temp * temp

# 21 
def is_palin(s):
    l = len(s) // 2
    for i in range(l):
        if s[i] != s[len(s) - i - 1]:
            return False
    return True

# 22 
def findSum(n):
    ans = 0
    temp = 0
    for i in range(1, n+1):
        temp = i - 1
        num = 1
        while temp < n:
            if temp + i <= n:
                ans += i * num
            else:
                ans += (n - temp) * num
            temp += i
            num += 1
    return ans

# 23 
def getNextGap(gap):
    gap = gap * 10 // 13
    if gap < 1:
        return 1
    else:
        return gap

# 24 
def countNonDecreasing(n):
    k = 10
    count = 1
    for i in range(1, n+1):
        count *= k + i - 1
        count //= i
    return count

# 25 
def power(x, y):
    if y == 0:
        return 1
    elif y % 2 == 0:
        return power(x, y // 2) * power(x, y // 2)
    else:
        return x * power(x, y // 2) * power(x, y // 2)

# 26 
def power(x, y):
    if y == 0:
        return 1
    temp = power(x, y // 2)
    if y % 2 == 0:
        return temp * temp
    elif y > 0:
        return x * temp * temp
    else:
        return temp * temp / x

# 27 
def multiply(x, y):
    if y == 0:
        return 0
    elif y > 0:
        return x + multiply(x, y - 1)
    else:
        return -multiply(x, -y)

# 28 
def smallest(x, y, z):
    if y / x == 0:
        return y / z == 0 and y or z
    return x / z == 0 and x or z

# 29 
def is_power_of_four(n):
    if n == 0:
        return False
    while n != 1:
        if n % 4 != 0:
            return False
        n = n / 4
    return True

# 30 
def modInverse(a, m):
    m0 = m
    x0 = 0
    x1 = 1
    if (m == 1):
        return 0
    while (a > 1):
        q = a // m
        t = m
        m = a % m
        a = t
        t = x0
        x0 = x1 - q * x0
        x1 = t
    if (x1 < 0):
        x1 += m0
    return x1

# 31 
def cntRotations(s, n):
    s2 = s + s
    pre = [0] * (2 * n)
    for i in range(2 * n):
        if i != 0:
            pre[i] += pre[i - 1]
        if s2[i] == 'a' or s2[i] == 'e' or s2[i] == 'i' or s2[i] == 'o' or s2[i] == 'u':
            pre[i] += 1
    ans = 0
    for i in range(n - 1, 2 * n - 1):
        r = i
        l = i - n
        x = pre[r]
        if l >= 0:
            x -= pre[l]
        r = i - n // 2
        left = pre[r]
        if l >= 0:
            left -= pre[l]
        right = x - left
        if left > right:
            ans += 1
    return ans

# 32 
def binomial_coeff(n, k):
    res = 1
    if k > n - k:
        k = n - k
    for i in range(k):
        res *= n - i
        res //= i + 1
    return res

# 33 
def is_prefix(temp, s):
    if len(temp) < len(s):
        return False
    else:
        for i in range(len(s)):
            if s[i] != temp[i]:
                return False
        return True

# 34 
def lexicographically_smallest_string(s, n):
    last_zero = -1
    ans = ""
    for i in range(n-1, -1, -1):
        if s[i] == '0':
            last_zero = i
            break
    for i in range(n):
        if i <= last_zero and s[i] == '0':
            ans += s[i]
        elif i > last_zero:
            ans += s[i]
    return ans

# 35 
def calculateMax(n, m, k):
    ans = -1
    low = 0
    high = m
    while low <= high:
        mid = (low + high) // 2
        val = 0
        l = k - 1
        r = n - k
        val += mid
        if mid >= l:
            val += l * (2 * mid - l - 1) // 2
        else:
            val += mid * (mid - 1) // 2 + (l - mid)
        if mid >= r:
            val += r * (2 * mid - r - 1) // 2
        else:
            val += mid * (mid - 1) // 2 + (r - mid)
        if val <= m:
            ans = max(ans, mid)
            low = mid + 1
        else:
            high = mid - 1
    return ans

# 36 
def find_length(s, i, j):
    required = i
    length = 0
    for curr in s:
        if curr == required:
            length += 1
            if required == i:
                required = j
            else:
                required = i
    return length

# 37 
def check_reverse(leftSum, rightSum):
    rev = 0
    temp = rightSum
    while temp != 0:
        rev = rev * 10 + temp % 10
        temp //= 10
    if rev == leftSum:
        return True
    return False

# 38 
def is_composite(n):
    if n <= 1:
        return False
    if n <= 3:
        return False
    if n % 2 == 0 or n % 3 == 0:
        return True
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return True
        i = i + 6
    return False

# 39 
def min_deletion(s):
    n = len(s)
    first_idx = -1
    last_idx0 = -1
    for i in range(n):
        if s[i] == '1':
            first_idx = i
            break
    for i in range(n-1, -1, -1):
        if s[i] == '0':
            last_idx0 = i
            break
    if first_idx == -1 or last_idx0 == -1:
        return 0
    count1 = 0
    count0 = 0
    for i in range(last_idx0):
        if s[i] == '1':
            count1 += 1
    for i in range(first_idx+1, n):
        if s[i] == '1':
            count0 += 1
    return min(count0, count1)

# 40 
def minSteps(s, n):
    smaller, cost = 0, 0
    f = [0] * 26
    for i in range(n):
        currEle = ord(s[i]) - ord('a')
        smaller = 0
        for j in range(currEle + 1):
            if f[j] != 0:
                smaller += f[j]
        if smaller == 0:
            cost += i + 1
        else:
            cost += i - smaller + 1
        f[ord(s[i]) - ord('a')] += 1
    return cost

# 41 
def numberOfWays(n):
    count = 0
    for a in range(1, n):
        for b in range(n):
            c = n - (a + b)
            if a + b > c and a + c > b and b + c > a:
                count += 1
    return count

# 42 
def slope_of_num(num, n):
    slope = 0
    for i in range(1, n - 1):
        if num[i] > num[i - 1] and num[i] > num[i + 1]:
            slope += 1
        elif num[i] < num[i - 1] and num[i] < num[i + 1]:
            slope += 1
    return slope

# 43 
def middle_of_three(a, b, c):
    x = a - b
    y = b - c
    z = a - c
    if x * y > 0:
        return b
    elif x * z > 0:
        return c
    else:
        return a

# 44 
def countMaxSetBits(left, right):
    while (left | (left + 1)) <= right:
        left |= left + 1
    return left

# 45 
def find_s(s):
    l = 1
    r = (s // 2) + 1
    while l <= r:
        mid = (l + r) // 2
        sum = mid * (mid + 1) // 2
        if sum == s:
            return mid
        elif sum > s:
            r = mid - 1
        else:
            l = mid + 1
    return -1

# 46 
def check(s):
    min = float('inf')
    max = float('-inf')
    sum = 0
    for i in range(len(s)):
        ascii = ord(s[i])
        if ascii < 96 or ascii > 122:
            return False
        sum += ascii
        if min > ascii:
            min = ascii
        if max < ascii:
            max = ascii
    min -= 1
    eSum = max * (max + 1) // 2 - min * (min + 1) // 2
    return sum == eSum

# 47 
def minimumPossibleProduct(k):
    res = 1
    r = (1 << k) - 1
    for i in range(k):
        res *= r - 1
    res *= r
    return res

# 48 
def findInGrid(i, j):
    if i == j:
        return i * i - (i - 1)
    elif i > j:
        if i % 2 == 0:
            return i * i - (j - 1)
        else:
            return (i - 1) * (i - 1) + 1 + (j - 1)
    else:
        if j % 2 == 0:
            return (j - 1) * (j - 1) + 1 + (i - 1)
        else:
            return j * j - (i - 1)

# 49 
def findMinOperationsReqEmpStr(s):
    cntOne = 0
    cntZero = 0
    n = len(s)
    for i in range(n):
        if s[i] == '0':
            if cntOne != 0:
                cntOne -= 1
            cntZero += 1
        else:
            if cntZero != 0:
                cntZero -= 1
            cntOne += 1
    return cntOne + cntZero

# 50 
def is_reachable(x1, y1, x2, y2):
    while x2 > x1 and y2 > y1:
        if x2 > y2:
            x2 %= y2
        else:
            y2 %= x2
    if x2 == x1:
        return (y2 - y1) >= 0 and (y2 - y1) % x1 == 0
    elif y2 == y1:
        return (x2 - x1) >= 0 and (x2 - x1) % y1 == 0
    else:
        return False

# 51 
def find_max_soln(n, x, y):
    ans = float('-inf')
    for k in range(n+1):
        if k % x == y:
            ans = max(ans, k)
    return ans if 0 <= ans <= n else -1

# 52 
def numberOfPairs(n):
    count = 0
    i = 1
    j = n - 1
    while i < j:
        if i + j == n:
            count += 1
        i += 1
        j -= 1
    return count

# 53 
def min_changes(s, n):
    count = 0
    zeros = 0
    ones = 0
    
    if s[0] != '1':
        count += 1
        ones += 1
        
    for i in range(1, n):
        if s[i] == '0':
            zeros += 1
        else:
            ones += 1
            
        if zeros > ones:
            zeros -= 1
            ones += 1
            count += 1
            
    return count

# 54 
def k_visible_from_left(n, k):
    if n == k:
        return 1
    if k == 1:
        ans = 1
        for i in range(1, n):
            ans *= i
        return ans
    return k_visible_from_left(n - 1, k - 1) + (n - 1) * k_visible_from_left(n - 1, k)

# 55 
def find(n, sum):
    if sum > 6 * n or sum < n:
        return 0
    if n == 1:
        if sum >= 1 and sum <= 6:
            return 1.0 / 6
        else:
            return 0
    s = 0
    for i in range(1, 7):
        s += find(n - 1, sum - i) / 6
    return s

# 56 
def binCoff(n, r):
    val = 1
    if r > n - r:
        r = n - r
    for i in range(r):
        val *= n - i
        val //= i + 1
    return val

# 57 
def get_mask(val):
    mask = 0
    if val == 0:
        return 1
    while val > 0:
        d = val % 10
        mask |= 1 << d
        val //= 10
    return mask

# 58 
def ways_to_k_adjacent_set_bits(n, k, current_index, adjacent_set_bits, last_bit):
    if current_index == n:
        if adjacent_set_bits == k:
            return 1
        return 0
    no_of_ways = 0
    if last_bit == 1:
        no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits + 1, 1)
        no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits, 0)
    elif last_bit == 0:
        no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits, 1)
        no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits, 0)
    return no_of_ways

# 59 
def check_func(i, j, st):
    if st[i] == '(' and st[j] == ')':
        return 1
    if st[i] == '(' and st[j] == '?':
        return 1
    if st[i] == '?' and st[j] == ')':
        return 1
    if st[i] == '[' and st[j] == ']':
        return 1
    if st[i] == '[' and st[j] == '?':
        return 1
    if st[i] == '?' and st[j] == ']':
        return 1
    if st[i] == '{' and st[j] == '}':
        return 1
    if st[i] == '{' and st[j] == '?':
        return 1
    if st[i] == '?' and st[j] == '}':
        return 1
    return 0

# 60 
def findGolomb(n):
    if n == 1:
        return 1
    return 1 + findGolomb(n - findGolomb(findGolomb(n - 1)))

# 61 
def allOnes(s, n):
    co = 0
    for i in range(len(s)):
        co += s[i] == '1' and 1 or 0
    return co == n

# 62 
def pad(n):
    p_prev_prev = 1
    p_prev = 1
    p_curr = 1
    p_next = 1
    for i in range(3, n+1):
        p_next = p_prev_prev + p_prev
        p_prev_prev = p_prev
        p_prev = p_curr
        p_curr = p_next
    return p_next

# 63 
def oddLengthPalindrome(k):
    palin = k
    k = k // 10
    while k > 0:
        rev = k % 10
        palin = palin * 10 + rev
        k = k // 10
    return palin

# 64 
def change_string(s0):
    s = list(s0)
    n = len(s0)
    
    if s[0] == '?':
        s[0] = 'a'
        if s[0] == s[1]:
            s[0] = chr(ord(s[0]) + 1)
    
    for i in range(1, n - 1):
        if s[i] == '?':
            s[i] = 'a'
            if s[i] == s[i - 1]:
                s[i] = chr(ord(s[i]) + 1)
            if s[i] == s[i + 1]:
                s[i] = chr(ord(s[i]) + 1)
            if s[i] == s[i - 1]:
                s[i] = chr(ord(s[i]) + 1)
    
    if s[n - 1] == '?':
        s[n - 1] = 'a'
        if s[n - 1] == s[n - 2]:
            s[n - 1] = chr(ord(s[n - 1]) + 1)
    
    return ''.join(s)

# 65 
def totalHammingDistance(n):
    i = 1
    sum = 0
    while n / i > 0:
        sum += n / i
        i = i * 2
    return sum

# 66 
def checkBitonic(s):
    i = 1
    while i < len(s):
        if s[i] > s[i-1]:
            continue
        if s[i] <= s[i-1]:
            break
    if i == len(s) - 1:
        return 1
    j = i + 1
    while j < len(s):
        if s[j] < s[j-1]:
            continue
        if s[j] >= s[j-1]:
            break
    i = j
    if i != len(s):
        return 0
    return 1

# 67 
def ends_with(str, pat):
    pat_len = len(pat)
    str_len = len(str)
    if pat_len > str_len:
        return False
    pat_len -= 1
    str_len -= 1
    while pat_len >= 0:
        if pat[pat_len] != str[str_len]:
            return False
        pat_len -= 1
        str_len -= 1
    return True

# 68 
def getSum(n, d):
    if n < d:
        return 0
    while n % 10 != d:
        n -= 1
    k = n // 10
    return (k + 1) * d + (k * 10 + 10 * k * k) // 2

# 69 
def balanced_string_by_swapping(s):
    unbalanced_pair = 0
    for i in range(len(s)):
        if unbalanced_pair > 0 and s[i] == ']':
            unbalanced_pair -= 1
        elif s[i] == '[':
            unbalanced_pair += 1
    return (unbalanced_pair + 1) // 2

# 70 
def compute_hash(s):
    p = 31
    mod = int(1e9) + 7
    hash_val = 0
    mul = 1
    for ch in s:
        hash_val = (hash_val + (ord(ch) - ord('a') + 1) * mul) % mod
        mul = mul * p % mod
    return int(hash_val)

# 71 
def count_of_substring_with_only_ones(s):
    res = 0
    count = 0
    for i in range(len(s)):
        count = int(s[i] == '1') + 1 if s[i] == '1' else 0
        res = res + count
    return res

# 72 
def composite(n):
    flag = 0
    c = 0
    for j in range(1, n+1):
        if n % j == 0:
            c += 1
    if c >= 3:
        flag = 1
    return flag

# 73 
def isDivBySix(s, n):
    sum = 0
    for i in range(n):
        sum += ord(s[i]) - 96
    if sum % 3 != 0:
        return False
    lastDigit = ord(s[n-1]) - 96
    if lastDigit % 2 != 0:
        return False
    return True

# 74 
def IsRedundantBraces(s):
    a = 0
    b = 0
    for i in range(len(s)):
        if s[i] == '(' and s[i+2] == ')':
            return True
        if s[i] == '*' or s[i] == '+' or s[i] == '-' or s[i] == '/':
            a += 1
        if s[i] == '(':
            b += 1
    if b > a:
        return True
    return False

# 75 
def countSubStr(s, n):
    count = 0
    i = 0
    while i < n - 2:
        if s[i] == '0' and s[i+1] == '1' and s[i+2] == '0':
            count += 1
            i += 3
        elif s[i] == '1' and s[i+1] == '0' and s[i+2] == '1':
            count += 1
            i += 3
        else:
            i += 1
    return count

# 76 
def prefixOccurrences(s):
    c = s[0]
    countC = 0
    for i in range(len(s)):
        if s[i] == c:
            countC += 1
    return countC

# 77 
def is_valid(s, length):
    for i in range(1, length):
        if s[i] == s[i - 1]:
            return False
    return True

# 78 
def count(s, k):
    n = len(s)
    d = 0
    count = 0
    for i in range(n):
        d += ord(s[i])
    if d % k == 0:
        count += 1
    for i in range(k, n):
        prev = ord(s[i - k])
        d -= prev
        d += ord(s[i])
        if d % k == 0:
            count += 1
    return count

# 79 
def find_substring_count(s):
    result = 0
    n = len(s)
    i = 0
    while i < n - 1:
        if ord(s[i]) + 1 == ord(s[i + 1]):
            result += 1
            while i < n - 1 and ord(s[i]) + 1 == ord(s[i + 1]):
                i += 1
        i += 1
    return result

# 80 
def find(s1, s2):
    len1 = len(s1)
    len2 = len(s2)
    
    if len1 != len2:
        return False
    
    d = [0] * len1
    d[0] = ord(s2[0]) - ord(s1[0])
    
    for i in range(1, len1):
        if ord(s1[i]) > ord(s2[i]):
            return False
        else:
            d[i] = ord(s2[i]) - ord(s1[i])
    
    for i in range(len1 - 1):
        if d[i] < d[i + 1]:
            return False
    
    return True

# 81 
def is_in_given_base(s, base):
    if base > 16:
        return False
    elif base <= 10:
        for i in range(len(s)):
            if not('0' <= s[i] < '0' + base):
                return False
    else:
        for i in range(len(s)):
            if not(('0' <= s[i] < '0' + base) or ('A' <= s[i] < 'A' + base - 10)):
                return False
    return True

# 82 
def countNonEmptySubstr(s):
    n = len(s)
    return n * (n + 1) // 2

# 83 
def even_decimal_value(s, n):
    result = 0
    for i in range(n):
        for j in range(i, n):
            decimal_value = 0
            power_of_2 = 1
            for k in range(i, j+1):
                decimal_value += (int(s[k]) - 48) * power_of_2
                power_of_2 *= 2
            if decimal_value % 2 == 0:
                result += 1
    return result

# 84 
def calculate(s):
    ans = 6
    for i in range(10):
        for j in range(10):
            for k in range(10):
                for l in range(10):
                    for m in range(10):
                        for n in range(10):
                            if i + j + k == l + m + n:
                                c = 0
                                if i != ord(s[0]) - ord('0'):
                                    c += 1
                                if j != ord(s[1]) - ord('0'):
                                    c += 1
                                if k != ord(s[2]) - ord('0'):
                                    c += 1
                                if l != ord(s[3]) - ord('0'):
                                    c += 1
                                if m != ord(s[4]) - ord('0'):
                                    c += 1
                                if n != ord(s[5]) - ord('0'):
                                    c += 1
                                if c < ans:
                                    ans = c
    return ans

# 85 
def xorZero(s):
    oneCount, zeroCount = 0, 0
    n = len(s)
    for i in range(n):
        if s[i] == '1':
            oneCount += 1
        else:
            zeroCount += 1
    if oneCount % 2 == 0:
        return zeroCount
    return oneCount

# 86 
def evenLength(n):
    res = n
    for j in range(len(n)-1, -1, -1):
        res += n[j]
    return res

# 87 
def countSubstringWithEqualEnds(s):
    result = 0
    n = len(s)
    for i in range(n):
        for j in range(i, n):
            if s[i] == s[j]:
                result += 1
    return result

# 88 
def normal_slope(a, b, x, y1):
    g = a / 2
    f = b / 2
    if g - x == 0:
        return -1
    slope = (f - y1) / (g - x)
    if slope == 0:
        return -2
    return slope

# 89 
def orthogonality(x1, y1, x2, y2, r1, r2):
    dsquare = (x1 - x2)**2 + (y1 - y2)**2
    if dsquare == r1**2 + r2**2:
        return True
    else:
        return False

# 90 
def findAreaShaded(a):
    sqArea = a * a
    semiCircleArea = 3.14 * (a * a) / 8
    shadedArea = 4 * semiCircleArea - sqArea
    return shadedArea

# 91 
def factorial(a, b):
    res = 1
    for i in range(1, a + b + 1):
        res = res * i
    for i in range(1, a + 1):
        res = res / i
    for i in range(1, b + 1):
        res = res / i
    return res

# 92 
import math

def factor_tree(n):
    height = 0
    while n > 1:
        flag = False
        for i in range(2, int(math.sqrt(n)) + 1):
            if n % i == 0:
                n = n / i
                flag = True
                break
        if not flag:
            break
        height += 1
    return height

# 93 
def find_if_possible(n, s, x):
    if s >= x and s % 2 == x % 2:
        if n >= 3:
            return "Yes"
        elif n == 1:
            if s == x:
                return "Yes"
            else:
                return "No"
        elif n == 2:
            c = (s - x) // 2
            a = c
            b = c
            a += x
            if (a ^ b) == x:
                return "Yes"
            else:
                return "No"
    return "No"

# 94 
def maximumTripletXor(a, b, c):
    ans = 0
    for i in range(30, -1, -1):
        cur = 1 << i
        if a >= cur:
            ans += cur
            a -= cur
        elif b >= cur:
            ans += cur
            b -= cur
        elif c >= cur:
            ans += cur
            c -= cur
    return ans

# 95 
def itemType(n):
    count = 0
    day = 1
    while count + day * (day + 1) // 2 < n:
        count += day * (day + 1) // 2
        day += 1
    for type in range(day, 0, -1):
        count += type
        if count >= n:
            return type
    return 0

# 96 
def maxGcdInRange(l, r):
    ans = 1
    for z in range(r, l, -1):
        if (r // z - (l - 1) // z) > 1:
            ans = z
            break
    return ans

# 97 
def sum_of_digits(n):
    sum = 0
    while n != 0:
        sum += n % 10
        n = n // 10
    return sum

# 98 
def isRepUnitNum(n, b):
    length = 0
    countOne = 0
    while n != 0:
        r = n % b
        length += 1
        if r == 1:
            countOne += 1
        n = n // b
    return countOne >= 3 and countOne == length

# 99 
def isStraightLineNum(n):
    if n <= 99:
        return False
    s = str(n)
    d = ord(s[1]) - ord(s[0])
    for i in range(2, len(s)):
        if ord(s[i]) - ord(s[i-1]) != d:
            return False
    return True

# 100 
def getCount(d, n):
    no = n // d
    result = no
    p = 2
    while p * p <= no:
        if no % p == 0:
            while no % p == 0:
                no //= p
            result -= result // p
        p += 1
    if no > 1:
        result -= result // no
    return result

# 101 
def isEvenParity(x):
    parity = 0
    while x != 0:
        if x % 2 == 1:
            parity += 1
        x = x >> 1
    if parity % 2 == 0:
        return True
    else:
        return False

# 102 
def is_perfect(n):
    sum = 1
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            if i * i != n:
                sum = sum + i + n // i
            else:
                sum = sum + i
    if sum == n and n != 1:
        return n
    return 0

# 103 
def log_a_to_base_b(a, b):
    return 1 + log_a_to_base_b(a // b, b) if a > b - 1 else 0

# 104 
def usingBinarySearch(start, end, n, s):
    if start >= end:
        return start
    mid = start + (end - start) // 2
    totalSum = n * (n + 1) // 2
    midSum = mid * (mid + 1) // 2
    if totalSum - midSum <= s:
        return usingBinarySearch(start, mid, n, s)
    return usingBinarySearch(mid + 1, end, n, s)

# 105 
def minInt(s):
    s1 = list(s)
    for i in range(len(s)):
        if s1[i] >= '5':
            s1[i] = chr(ord('9') - ord(s1[i]) + ord('0'))
    if s1[0] == '0':
        s1[0] = '9'
    return ''.join(s1)

# 106 
def countTriplets(a, b, c):
    ans = 0
    for i in range(1, a+1):
        for j in range(1, b+1):
            for k in range(1, c+1):
                if i * k > j * j:
                    ans += 1
    return ans

# 107 
def topsyTurvy(s):
    for i in range(len(s)):
        if s[i] == '2' or s[i] == '4' or s[i] == '5' or s[i] == '6' or s[i] == '7' or s[i] == '9':
            return False
    return True

# 108 
def sum_of_last_digit(n, m):
    sum = 0
    k = n // m
    arr = [m * (i + 1) % 10 for i in range(10)]
    sum += sum(arr)
    rem = k % 10
    ans = k // 10 * sum
    ans += sum(arr[:rem])
    return ans

# 109 
def total_pay(total_items, price_of_one_item, n, m):
    free_items = total_items // (n + m)
    actual = total_items - free_items
    amount = actual * price_of_one_item
    return amount

# 110 
def min_operations(x, y, p, q):
    if y % x != 0:
        return -1
    d = y // x
    a = 0
    while d % p == 0:
        d //= p
        a += 1
    b = 0
    while d % q == 0:
        d //= q
        b += 1
    if d != 1:
        return -1
    return a + b

# 111 
def is_mersenne(n):
    while n != 0:
        r = n % 2
        if r == 0:
            return False
        n /= 2
    return True

# 112 
def findThirdDigit(n):
    if n < 3:
        return 0
    return 1 if (n & 1) != 0 else 6

# 113 
def isOddLength(num):
    count = 0
    while num > 0:
        num //= 10
        count += 1
    if count % 2 != 0:
        return True
    return False

# 114 
def check_is_possible(l, r, k):
    count = 0
    for i in range(l, r+1):
        if i % k == 0:
            count += 1
    return count > 1

# 115 
def bytes(kilobytes):
    b = kilobytes * 1024
    return b

# 116 
def octahedral_num(n):
    return n * (2 * n * n + 3) // 3

# 117 
def checkEqual(s):
    for i in range(len(s)):
        if s[i] != '1' and s[i] != '0' and s[i] != '8':
            return "No"
    start, end = 0, len(s) - 1
    while start < end:
        if s[start] != s[end]:
            return "No"
        start += 1
        end -= 1
    return "Yes"

# 118 
def is_undulating(n):
    if len(n) <= 2:
        return False
    for i in range(2, len(n)):
        if n[i - 2] != n[i]:
            return False
    return True

# 119 
def first_digit(n):
    while n >= 10:
        n = n // 10
    return n

# 120 
def countDigit(n):
    if n == 0:
        return 0
    return 1 + countDigit(n // 1<script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script>

# 121 
def is_divisible_by_5(s):
    n = len(s)
    return s[n-1] == '0' or s[n-1] == '5'

# 122 
def inv(a, m):
    m0 = m
    x0 = 0
    x1 = 1
    if m == 1:
        return 0
    while a > 1:
        q = a // m
        t = m
        m = a % m
        a = t
        t = x0
        x0 = x1 - q * x0
        x1 = t
    if x1 < 0:
        x1 += m0
    return x1

# 123 
def only_first_and_last_are_set(n):
    if n == 1:
        return True
    if n == 2:
        return False
    return (n - 1) & (n - 2) == 0

# 124 
def divide(dividend, divisor):
    sign = -1 if (dividend < 0) ^ (divisor < 0) else 1
    dividend = abs(dividend)
    divisor = abs(divisor)
    quotient = 0
    temp = 0
    for i in range(31, -1, -1):
        if temp + (divisor << i) <= dividend:
            temp += divisor << i
            quotient |= 1 << i
    if sign == -1:
        quotient = -quotient
    return quotient

# 125 
def find_profession(level, pos):
    if level == 1:
        return 'e'
    if find_profession(level - 1, (pos + 1) // 2) == 'd':
        return pos % 2 != 0 and 'd' or 'e'
    return pos % ; 2 != 0 and 'e' or 'd'

# 126 
def hasCloseElements(numbers, threshold):
 for i in range(len(numbers)):
  for j in range(i + 1, len(numbers)):
   distance = abs(numbers[i] - numbers[j])
   if distance < threshold:
    return True
 return False

# 127 
def truncate_number(number):
    return number // 1.0

# 128 
def below_zero(operations):
    balance = 0
    for op in operations:
        balance += op
        if balance < 0:
            return True
    return False

# 129 
def meanAbsoluteDeviation(numbers):
    sum_num = 0
    for num in numbers:
        sum_num += num
    mean = sum_num / len(numbers)
    sum_abs_diff = 0
    for num in numbers:
        sum_abs_diff += abs(num - mean)
    return sum_abs_diff / len(numbers)

# 130 
def intersperse(numbers, delimiter):
    result = []
    if not numbers:
        return result
    for i in range(len(numbers) - 1):
        result.append(numbers[i])
        result.append(delimiter)
    result.append(numbers[-1])
    return result

# 131 
def sum_product(numbers):
    sum_value = 0
    prod_value = 1
    for n in numbers:
        sum_value += n
        prod_value *= n
    return [sum_value, prod_value]

# 132 
def all_prefixes(s):
    result = []
    for i in range(1, len(s) + 1):
        result.append(s[:i])
    return result

# 133 
def parse_music(music_string):
    current = ""
    result = []
    for i in range(len(music_string) + 1):
        if i == len(music_string) or music_string[i] == ' ':
            if current == "o":
                result.append(4)
            elif current == "o|":
                result.append(2)
            elif current == ".|":
                result.append(1)
            current = ""
        else:
            current += music_string[i]
    return result

# 134 
def strlen(s):
    return len(s)

# 135 
def factorize(n):
    factors = []
    i = 2
    while i <= n:
        if n % i == 0:
            n /= i
            factors.append(i)
        else:
            i += 1
    return factors

# 136 
def concatenate(strings):
    result = ""
    for s in strings:
        result += s
    return result

# 137 
def get_positive(l):
    result = []
    for i in range(len(l)):
        if l[i] > 0:
            result.append(l[i])
    return result

# 138 
def sort_even(l):
    evens = [l[i] for i in range(0, len(l), 2)]
    evens.sort()
    result = []
    for i in range(len(l)):
        if i % 2 == 0:
            result.append(evens[i//2])
        if i % 2 == 1:
            result.append(l[i])
    return result

# 139 
def decode_cyclic(s):
    output = ""
    i = 0
    while i <= len(s) - 3:
        x = s[i+2] + s[i:i+2]
        output += x
        i += 3
    return output + s[i:]

# 140 
def car_race_collision(n):
    return int(pow(n, 2))

# 141 
def incr_list(l):
    result = []
    for i in l:
        result.append(i + 1)
    return result

# 142 
def pairs_sum_to_zero(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if l[i] + l[j] == 0:
                return True
    return False

# 143 
def change_base(x, b):
    ret = ""
    while x > 0:
        ret = str(x%b) + ret
        x //= b
    return ret

# 144 
def median(l):
    l.sort()
    if len(l) % 2 == 1:
        return l[len(l) // 2]
    else:
        return (l[len(l) // 2 - 1] + l[len(l) // 2]) / 2.0

# 145 
def decode_shift(s):
    sb = ""
    for ch in s:
        w = chr((ord(ch) + 21 - ord('a')) % 26 + ord('a'))
        sb += w
    return sb

# 146 
def below_threshold(l, t):
    for n in l:
        if n >= t:
            return False
    return True

# 147 
def correctBracketing(brackets):
    depth = 0
    for b in brackets:
        if b == '<':
            depth += 1
        if b == '>':
            depth -= 1
        if depth < 0:
            return False
    return depth == 0

# 148 
def monotonic(l):
    incr = 0
    decr = 0
    for i in range(1, len(l)):
        if l[i] > l[i - 1]:
            incr = 1
        if l[i] < l[i - 1]:
            decr = 1
    return incr + decr != 2

# 149 
def derivative(xs):
    result = []
    for i in range(len(xs)):
        result.append(i * xs[i])
    return result

# 150 
def vowels_count(s):
    vowels = "aeiouAEIOU"
    count = 0
    for ch in s:
        if vowels.index(ch) != -1:
            count += 1
    if s[-1] == 'y' or s[-1] == 'Y':
        count += 1
    return count

# 151 
def digitSum(s):
    sum = 0
    for c in s:
        if c.isupper():
            sum += ord(c)
    return sum

# 152 
def fruit_distribution(s, n):
    num1 = ""
    num2 = ""
    flag = False
    for i in range(len(s)):
        if s[i].isdigit():
            if not flag:
                num1 += s[i]
            if flag:
                num2 += s[i]
        elif not flag and num1 != "":
            flag = True
    return n - int(num1) - int(num2)

# 153 
def pluck(arr):
    result = []
    for i in range(len(arr)):
        if arr[i] % 2 == 0:
            if not result:
                result.append(arr[i])
                result.append(i)
            elif arr[i] < result[0]:
                result[0] = arr[i]
                result[1] = i
    return result

# 154 
def strange_sort_list(lst):
    res = []
    lst.sort()
    l = 0
    r = len(lst) - 1
    while l < r:
        res.append(lst[l])
        l += 1
        res.append(lst[r])
        r -= 1										<code class="python">def strange_sort_list(lst):
    res = []
    lst.sort()
    l = 0
    r = len(lst) - 1
    while l < r:
        res.append(lst[l])
        l += 1
        res.append(lst[r])
        r -= 1
    if l == r:
        res.append(lst[l])
    return res</code>

# 155 
def triangleArea(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a:
        return -1
    s = (a + b + c) / 2
    return (s * (s - a) * (s - b) * (s - c)) ** 0.5

# 156 
def willItFly(q, w):
    sum = 0
    for i in range(len(q)):
        if not q[i].__eq__(q[len(q)-i-1]):
            return False
        sum += q[i]
    return sum <= w

# 157 
import math

def is_cube(a):
    a = abs(a)
    i = round(pow(a, 1.0/3))
    return pow(i, 3) == a

# 158 
def hex_key(num):
    key = "2357BD"
    total = 0
    for c in num:
        if key.index(c) == -1:
            total += 1
    return total

# 159 
def decimal_to_binary(dec):
    ans = ""
    if dec != 0:
        while dec > 0:
            ans = str(dec % 2) + ans
            dec //= 2
    else:
        ans = "0"
    return "db" + ans + "db"

# 160 
def prime_length(s):
    l = len(s)
    if l < 2:
        return False
    for i in range(2, l):
        if l % i == 0:
            return False
    return True

# 161 
def starts_one_ends(n):
    if n < 1:
        return 0
    if n == 1:
        return 1
    return int(18 * pow(10, n - 2))

# 162 
def add(lst):
    sum = 0
    for i in range(1, len(lst), 2):
        if lst[i] % 2 == 0:
            sum += lst[i]
    return sum

# 163 
def getRow(lst, x):
    coords = []
    for i in range(len(lst)):
        for j in range(len(lst[i])-1, -1, -1):
            if lst[i][j] == x:
                coords.append([i, j])
    return coords

# 164 
def next_smallest(lst):
    lst.sort()
    for i in range(1, len(lst)):
        if not lst[i].__eq__(lst[i - 1]):
            return lst[i]
    return -1

# 165 
def anyInt(a, b, c):
    if math.isclose(math.floor(a), a, rel_tol=1e-9) and math.isclose(math.floor(b), b, rel_tol=1e-9) and math.isclose(math.floor(c), c, rel_tol=1e-9):
        return False
    return abs(a + b - c) < 1e-9 or abs(a + c - b) < 1e-9 or abs(b + c - a) < 1e-9

# 166 
def count_up_to(n):
    primes = []
    for i in range(2, n):
        is_prime = True
        for j in range(2, i):
            if i % j == 0:
                is_prime = False
                break
        if is_prime:
            primes.append(i)
    return primes

# 167 
def closest_integer(value):
    w = float(value)
    return round(w)

# 168 
def make_a_pile(n):
    result = []
    for i in range(n):
        result.append(n + 2 * i)
    return result

# 169 
def word_strings(s):
    current = ""
    words = []
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == ' ' or s[i] == ',':
            if current != "":
                words.append(current)
                current = ""
        else:
            current += s[i]
    return words

# 170 
def rounded_avg(n, m):
    if n > m:
        return "-1"
    num = (m + n) // 2
    ret = ""
    while num > 0:
        ret = str(num % 2) + ret
        num //= 2
    return ret

# 171 
def unique_digits(x):
    digits = []
    for i in x:
        is_unique = True
        for c in str(i):
            if int(c) % 2 == 0:
                is_unique = False
                break
        if is_unique:
            digits.append(i)
    digits.sort()
    return digits

# 172 
def count_nums(arr):
    num = 0
    for n in arr:
        neg = -1 if n < 0 else 1
        n = abs(n)
        digits = [int(c) for c in str(n)]
        digits[0] *= neg
        sum_digits = sum(digits)
        if sum_digits > 0:
            num += 1
    return num

# 173 
def moveOneBall(arr):
    if not arr:
        return True
    num = 0
    for i in range(1, len(arr)):
        if arr[i] < arr[i - 1]:
            num += 1
    if arr[-1] > arr[0]:
        num += 1
    if num < 2:
        return True
    return False

# 174 
def exchange(lst1, lst2):
    odd = 0
    even = 0
    for n in lst1:
        if n % 2 == 1:
            odd += 1
    for n in lst2:
        if n % 2 == 0:
            even += 1
    if even >= odd:
        return "YES"
    return "NO"

# 175 
def odd_count(lst):
    results = []
    original_str = "the number of odd elements in the string i of the input."
    for s in lst:
        sum = 0
        for d in s:
            if d.isdigit() and int(d) % 2 == 1:
                sum += 1
        result = []
        for c in original_str:
            if c == 'i':
                result.append(str(sum))
            else:
                result.append(c)
        results.append(''.join(result))
    return results

# 176 
def minSubArraySum(nums):
    minSum = float('inf')
    sum = 0
    for num in nums:
        sum += num
        if minSum > sum:
            minSum = sum
        if sum > 0:
            sum = 0
    return minSum

# 177 
def max_fill(grid, capacity):
    res = 0
    for row in grid:
        sum = 0
        for n in row:
            sum += n
        if sum > 0:
            res += (sum - 1) // capacity + 1
    return res

# 178 
def select_words(s, n):
    vowels = "aeiouAEIOU"
    current = ""
    result = []
    consonant_num = 0
    
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == ' ':
            if consonant_num == n:
                result.append(current)
            current = ""
            consonant_num = 0
        else:
            current += s[i]
            if vowels.find(s[i]) == -1:
                consonant_num += 1
    
    return result

# 179 
def solution(lst):
    sum = 0
    for i in range(0, len(lst), 2):
        if lst[i] % 2 == 1:
            sum += lst[i]
    return sum

# 180 
def add_elements(arr, k):
    sum = 0
    for i in range(k):
        if -99 <= arr[i] <= 99:
            sum += arr[i]
    return sum

# 181 
def get_odd_collatz(n):
    odd_collatz = []
    while n != 1:
        if n % 2 == 1:
            odd_collatz.append(n)
            n = n * 3 + 1
        else:
            n /= 2
    odd_collatz.append(1)
    odd_collatz.sort()
    return odd_collatz

# 182 
def is_sorted(lst):
    for i in range(1, len(lst)):
        if lst[i] < lst[i - 1]:
            return False
        if i >= 2 and lst[i] == lst[i - 1] and lst[i] == lst[i - 2]:
            return False
    return True

# 183 
def intersection(interval1, interval2):
    inter1 = max(interval1[0], interval2[0])
    inter2 = min(interval1[1], interval2[1])
    l = inter2 - inter1
    if l < 2:
        return "NO"
    for i in range(2, l):
        if l % i == 0:
            return "NO"
    return "YES"

# 184 
def prod_signs(arr):
    if not arr:
        return -32768
    sum = 0
    prods = 1
    for i in arr:
        sum += abs(i)
        if i == 0:
            prods = 0
        if i < 0:
            prods = -prods
    return sum * prods

# 185 
def min_path(grid, k):
    n = len(grid)
    min_num = 0
    for i in range(n):
        for j in range(n):
            if grid[i][j] == 1:
                tmp = []
                if i != 0:
                    tmp.append(grid[i-1][j])
                if j != 0:
                    tmp.append(grid[i][j-1])
                if i != n - 1:
                    tmp.append(grid[i+1][j])
                if j != n - 1:
                    tmp.append(grid[i][j+1])
                min_num = min(tmp)
    ans = []
    for i in range(k):
        if i % 2 == 0:
            ans.append(1)
        else:
            ans.append(min_num)
    return ans

# 186 
def digits(n):
    prod = 0
    for digit in str(n):
        if int(digit) % 2 == 1:
            if prod == 0:
                prod = 1
            prod *= int(digit)
    return prod

# 187 
def is_nested(s):
    count = 0
    max_count = 0
    for ch in s:
        if ch == '[':
            count += 1
        if ch == ']':
            count -= 1
        if count < 0:
            count = 0
        if count > max_count:
            max_count = count
        if count <= max_count - 2:
            return True
    return False

# 188 
def sum_squares(lst):
    sum = 0
    for i in lst:
        sum += math.ceil(i) ** 2
    return sum

# 189 
def can_arrange(arr):
    index = -1
    for i in range(len(arr)):
        if arr[i] <= i:
            index = i
    return index

# 190 
def largest_smallest_integers(lst):
    max_neg = max_pos = None
    for n in lst:
        if n < 0 and (max_neg is None or n > max_neg):
            max_neg = n
        if n > 0 and (min_pos is None or n < min_pos):
            min_pos = n
    return [max_neg, min_pos]

# 191 
def fix_spaces(text):
    res = ""
    space_len = 0
    for i in range(len(text)):
        if i == len(text) - 1 or text[i] != ' ':
            if space_len == 1:
                res += '_'
            elif space_len == 2:
                res += '__'
            elif space_len > 2:
                res += '-'
            space_len = 0
            if i != len(text) - 1:
                res += text[i]
        else:
            space_len += 1
    return res

# 192 
def filename_check(file_name):
    digit_num = 0
    dot_num = 0
    
    if len(file_name) < 5 or not file_name[0].isalpha():
        return "No"
    
    suffix = file_name[-4:]
    if suffix != ".txt" and suffix != ".exe" and suffix != ".dll":
        return "No"
    
    for c in file_name:
        if c.isdigit():
            digit_num += 1
        if c == '.':
            dot_num += 1
    
    if digit_num > 3 or dot_num != 1:
        return "No"
    
    return "Yes"

# 193 
def sum_squares(lst):
    sum = 0
    for i in range(len(lst)):
        if i % 3 == 0:
            sum += lst[i] * lst[i]
        elif i % 4 == 0:
            sum += lst[i] * lst[i] * lst[i]
        else:
            sum += lst[i]
    return sum

# 194 
def words_in_sentence(sentence):
    result = ""
    current = ""
    for i in range(len(sentence) + 1):
        if i == len(sentence) or sentence[i] == ' ':
            is_prime = True
            l = len(current)
            if l < 2:
                is_prime = False
            for j in range(2, l):
                if l % j == 0:
                    is_prime = False
                    break
            if is_prime:
                result += current + ' '
            current = ""
        else:
            current += sentence[i]
    if len(result) > 0:
        result = result[:-1]
    return result

# 195 
def simplify(x, n):
    a = 0
    b = 0
    c = 0
    d = 0
    
    for i in range(len(x)):
        if x[i] == '/':
            a = int(x[:i])
            b = int(x[i+1:])
    
    for i in range(len(n)):
        if n[i] == '/':
            c = int(n[:i])
            d = int(n[i+1:])
    
    return (a * c) % (b * d) == 0

# 196 
def special_filter(nums):
    count = 0
    for num in nums:
        if num > 10:
            w = str(num)
            if int(w[0]) % 2 == 1 and int(w[-1]) % 2 == 1:
                count += 1
    return count

# 197 
def get_max_triples(n):
    arr = []
    for i in range(1, n + 1):
        arr.append(i * i - i + 1)
    count = 0
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if (arr[i] + arr[j] + arr[k]) % 3 == 0:
                    count += 1
    return count

# 198 
def double_the_difference(lst):
    sum = 0
    for d in lst:
        num = round(d)
        if d == num:
            if num > 0 and num % 2 == 1:
                sum += num * num
    return sum

# 199 
def compare(game, guess):
    result = []
    for i in range(len(game)):
        result.append(abs(game[i] - guess[i]))
    return result

# 200 
def strongest_extension(class_name, extensions):
    strongest = ""
    max = float('-inf')
    for extension in extensions:
        strength = 0
        for chr in extension:
            if chr.isupper():
                strength += 1
            if chr.islower():
                strength -= 1
        if strength > max:
            max = strength
            strongest = extension
    return f"{class_name}.{strongest}"

# 201 
def intToMiniRoman(number):
    num = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    sym = ["m", "cm", "d", "cd", "c", "xc", "l", "xl", "x", "ix", "v", "iv", "i"]
    pos = 0
    res = ""
    while number > 0:
        while number >= num[pos]:
            res += sym[pos]
            number -= num[pos]
        if number > 0:
            pos += 1
    return res

# 202 
def eat(number, need, remaining):
    return [number + need, 0] if need > remaining else [number + need, remaining - need]

# 203 
def doAlgebra(ops, operands):
    nums = operands.copy()
    currentOps = ops.copy()
    i = len(currentOps) - 1
    while i >= 0:
        if currentOps[i] == "**":
            nums[i] = int(pow(nums[i], nums[i + 1]))
            nums.pop(i + 1)
            currentOps.pop(i)
        i -= 1
    i = 0
    while i < len(currentOps):
        if currentOps[i] == "*":
            nums[i] = nums[i] * nums[i + 1]
            nums.pop(i + 1)
            currentOps.pop(i)
        elif currentOps[i] == "//":
            nums[i] = nums[i] // nums[i + 1]
            nums.pop(i + 1)
            currentOps.pop(i)
        else:
            i += 1
    i = 0
    while i < len(currentOps):
        if currentOps[i] == "+":
            nums[i] = nums[i] + nums[i + 1]
            nums.pop(i + 1)
            currentOps.pop(i)
        elif currentOps[i] == "-":
            nums[i] = nums[i] - nums[i + 1]
            nums.pop(i + 1)
            currentOps.pop(i)
        else:
            i += 1
    return nums[0]

# 204 
def generate_integers(a, b):
    lower = max(2, min(a, b))
    upper = min(8, max(a, b))
    result = []
    for i in range(lower, upper + 1, 2):
        result.append(i)
    return result

# 205 
def isStepNum(n):
    prevDigit = -1
    while n > 0:
        curDigit = n % 10
        if prevDigit != -1:
            if abs(curDigit - prevDigit) != 1:
                return False
        n //= 10
        prevDigit = curDigit
    return True

# 206 
import math

def numOfWays(n, k):
    p = 1
    if k % 2 != 0:
        p = -1
    return int(math.pow(n - 1, k) + p * (n - 1)) // n

# 207 
import math

def find_divisors(n):
    v = []
    for i in range(1, int(math.sqrt(n)) + 1):
        if n % i == 0:
            if n / i == i:
                v.append(i)
            else:
                v.append(i)
                v.append(n // i)
    return v

# 208 
def eggDrop(n, k):
    if k == 1 or k == 0:
        return k
    if n == 1:
        return k
    min = float('inf')
    x, res = 0, 0
    for x in range(1, k+1):
        res = max(egg, eggDrop(n-1, x-1), eggDrop(n, k-x))
        if res < min:
            min = res
    return min + 1

# 209 
import math

def is_power_of_two(n):
    if n == 0:
        return False
    return math.ceil(math.log(n) / math.log(2)) == math.floor(math.log(n) / math.log(2))

# 210 
def shortestPalindrome(s):
    n = len(s)
    v = []
    for i in range(n):
        l = i
        r = i
        ans1 = ""
        ans2 = ""
        while l >= 0 and r < n and s[l] == s[r]:
            ans1 += s[l]
            l -= 1
            r += 1
        l = i - 1
        r = i
        while l >= 0 and r < n and s[l] == s[r]:
            ans2 += s[l]
            l -= 1
            r += 1
        v.append(ans1)
        v.append(ans2)
    ans = v[0]
    for i in range(len(v)):
        if v[i] != "":
            if ans[0] >= v[i][0]:
                ans = v[i]
    return ans

# 211 
def minimumAdjacentDifference(a, n, k):
    minDiff = float('inf')
    for i in range(k+1):
        maxDiff = float('-inf')
        for j in range(n - k - 1):
            for p in range(i, i + j + 1):
                maxDiff = max(maxDiff, a[p + 1] - a[p])
        minDiff = min(minDiff, maxDiff)
    return minDiff

# 212 
def cal(arr, mid):
    chocolate = 0
    for i in arr:
        if i >= mid:
            chocolate += i - mid
    return chocolate

# 213 
def check(v, a, m):
    tec = 0
    ans = 0
    b = [0] * (len(a) + 3)
    for i in range(len(a)):
        tec -= b[i]
        if a[i] + tec < v:
            mov = v - a[i] - tec
            ans += mov
            tec += mov
            b[i + 2] = mov
    return ans <= m

# 214 
def largestNum(arr):
    res = 0
    arr.sort()
    l = 0
    r = len(arr) - 1
    while l < r:
        sum = arr[l] + arr[r]
        if sum == 0:
            res = max(res, max(arr[l], arr[r]))
            return res
        elif sum < 0:
            l += 1
        else:
            r -= 1
    return res

# 215 
def binary_search(p, n):
    i = 0
    j = len(p) - 1
    index = -1
    while i <= j:
        mid = i + (j - i) // 2
        if p[mid] >= n:
            index = mid
            j = mid - 1
        else:
            i = mid + 1
    return index

# 216 
def find_min_length(arr):
    index = len(arr) - 1
    while index > 0 and arr[index] >= arr[index - 1]:
        index -= 1
    return index

# 217 
import math

def minDigits(n, k):
    digitsNum = math.floor(math.log(n, 10)) + 1
    tempSum = 0
    temp = digitsNum
    result = 0
    x = 0
    v = 0
    sum = 0
    num2 = n
    while num2 != 0:
        sum += num2 % 10
        num2 //= 10
    if sum <= k:
        x = 0
    else:
        while temp > 0:
            v = n // 10**(temp - 1)
            tempSum += v % 10
            if tempSum >= k:
                v //= 10
                v += 1
                result = v * 10**temp
                break
            temp -= 1
        x = result - n
    if x >= 0:
        return x
    else:
        return -1

# 218 
def check_for_perfect_square(arr, i, j):
    sum = 0
    for m in range(i, j+1):
        sum += arr[m]
    
    low = 0
    high = sum // 2
    
    while low <= high:
        mid = low + (high - low) // 2
        if mid * mid == sum:
            return mid
        elif mid * mid > sum:
            high = mid - 1
        else:
            low = mid + 1
    
    return -1

# 219 
def minFlips(mat, s):
    n = len(mat)
    m = len(mat[0])
    count = 0
    for i in range(n):
        for j in range(m):
            if mat[i][j] != int(s[i + j]):
                count += 1
    return count

# 220 
def constructTree(n, edges):
    adjl = [[] for _ in range(n)]
    for e in edges:
        u, v = e[0], e[1]
        adjl[u].append(v)
        adjl[v].append(u)
    return adjl

# 221 
def find_sum_of_values(v, parent, values_children):
    cur_node = v
    sum = 0
    while cur_node != -1:
        sum += values_children[cur_node]
        cur_node = parent[cur_node]
    return sum

# 222 
def get_distinct(d, count):
    num = 0
    count = int(pow(10, count - 1))
    while count > 0:
        num += count * d
        count //= 10
    return num

# 223 
def is_increasing(arr):
    for i in range(len(arr) - 1):
        if arr[i] > arr[i + 1]:
            return False
    return True

# 224 
def minAdjSwaps(mat):
    n = len(mat)
    cntZero = [0] * n
    for i in range(n):
        for j in range(n-1, -1, -1):
            if mat[i][j] == 0:
                cntZero[i] += 1

    cntSwaps = 0
    for i in range(n):
        if cntZero[i] < n - i - 1:
            first = i
            while first < n and cntZero[first] < n - i - 1:
                first += 1
            if first == n:
                return -1
            while first > i:
                cntZero[first], cntZero[first - 1] = cntZero[first - 1], cntZero[first]
                first -= 1
                cntSwaps += 1
    return cntSwaps

# 225 
def solve(values, salary, mod):
    ret = 0
    amt = 0
    values.sort()
    salary.sort()
    while len(salary) > 0:
        while len(values) > 0 and values[-1] >= salary[-1]:
            amt += 1
            values.remove(values[-1])
        if amt == 0:
            return 0
        ret *= amt
        ret %= mod
        salary.remove(salary[-1])
    return ret

# 226 
def organize_in_order(vec, op, n):
    result = [0] * n
    vec.sort()
    i, j, k = 0, n - 1, 0
    while i <= j and k <= n - 2:
        if op[k] == '<':
            result[k] = vec[i]
            i += 1
        else:
            result[k] = vec[j]
            j -= 1
        k += 1
    result[n - 1] = vec[i]
    return result

# 227 
def count_points(n, m, a, b, x, y):
    a.sort()
    b.sort()
    j = 0
    count = 0
    for i in range(n):
        while j < m:
            if a[i] + y < b[j]:
                break
            if b[j] >= a[i] - x and b[j] <= a[i] + y:
                count += 1
                j += 1
                break
            else:
                j += 1
    return count

# 228 
def are_same(a, b):
    a.sort()
    b.sort()
    return a == b

# 229 
def count_number_of_strings(s):
    n = len(s) - 1
    count = int(pow(2, n))
    return count

# 230 
def prime_power(x):
    prime_pow = []
    for i in range(2, int(x**0.5) + 1):
        if x % i == 0:
            p = 1
            while x % i == 0:
                x //= i
                p *= i
            prime_pow.append(p)
    if x > 1:
        prime_pow.append(x)
    return prime_pow

# 231 
import math

def is_perfect(n0):
    n = math.sqrt(n0)
    if math.floor(n) != math.ceil(n):
        return False
    return True

# 232 
def findSum(l, r):
    arr = []
    i = 0
    x = 2
    while i <= r:
        arr.append(i + x)
        if i + 1 <= r:
            arr.append(i + 1 + x)
        x *= -1
        i += 2
    sum = 0
    for i in range(l, r+1):
        sum += arr[i]
    return sum

# 233 
import math

def results(n, k):
    return int(math.pow(n, 1.0 / math.pow(2.0, k)))

# 234 
def factors(n):
    v = []
    v.append(1)
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            v.append(i)
            if n // i != i:
                v.append(n // i)
    return v

# 235 
import math

def smallest_num(n):
    x = math.pow(10, (n - 1) / 2.0)
    return math.ceil(x)

# 236 
def smallest(s):
    a = [0] * len(s)
    for i in range(len(s)):
        a[i] = ord(s[i]) - ord('0')
    b = []
    for i in range(len(a)):
        if a[i] % 2 != 0:
            b.append(a[i])
    b.sort()
    if len(b) > 1:
        return b[0] * 10 + b[1]
    return -1

# 237 
def Diagonals(a, b, c, d):
    import math
    ans = []
    ans.append(math.sqrt((a*c + b*d) * (a*d + b*c) / (a*b + c*d)))
    ans.append(math.sqrt((a*c + b*d) * (a*b + c*d) / (a*d + b*c)))
    return ans

# 238 
import math

def find_number_of_digits(n, b):
    dig = int(math.floor(math.log(n) / math.log(b))) + 1
    return dig

# 239 
import math

def n_gon(n):
    if n % 4 == 0:
        pro_angle_var = math.pi * (180.0 / n) / 180
    else:
        pro_angle_var = math.pi * (180.0 / (2 * n)) / 180

    neg_x = 1.0e+99
    pos_x = -1.0e+99
    neg_y = 1.0e+99
    pos_y = -1.0e+99

    for j in range(n):
        px = math.cos(2 * math.pi * j / n + pro_angle_var)
        py = math.sin(2 * math.pi * j / n + pro_angle_var)
        neg_x = min(neg_x, px)
        pos_x = max(pos_x, px)
        neg_y = min(neg_y, py)
        pos_y = max(pos_y, py)

    opt2 = max(pos_x - neg_x, pos_y - neg_y)
    return opt2 / math.sin(math.pi / n) / 2

# 240 
import math

def find_max_k(n):
    p = int(math.log(n) / math.log(2))
    return int(math.pow(2, p))

# 241 
import math

def nth_fibo(n):
    a = (math.pow(5, 0.5) + 1) / 2
    b = (-1 * math.pow(5, 0.5) + 1) / 2
    r = math.pow(5, 0.5)
    ans = (math.pow(a, n) - math.pow(b, n)) / r
    return int(ans)

# 242 
import math

def find_prob(l, r):
    count_of_ps = math.floor(math.sqrt(r)) - math.ceil(math.sqrt(l)) + 1
    total = r - l + 1
    prob = count_of_ps / total
    return prob

# 243 
import math

def previous_fibonacci(n):
    a = n / ( ( 1 + math.sqrt(5) ) / 2.0 )
    return round(a)

# 244 
def distPrime(arr, allPrimes):
    list1 = []
    for i in allPrimes:
        for j in arr:
            if j % i == 0:
                list1.append(i)
                break
    return list1

# 245 
def get_array(n):
    ans = []
    p2 = 1
    while n > 0:
        if n % 2 == 1:
            ans.append(p2)
        n >>= 1
        p2 *= 2
    return ans

# 246 
def maximum_length(a):
    counts = [0]*11
    ans = 0
    for index in range(len(a)):
        counts[a[index]] += 1
        k = [i for i in counts if i != 0]
        k.sort()
        if (len(k) == 1 and k[0] == 1) or (len(k) > 1 and k[0] == 1 and k[1] == k[0]) or (len(k) > 1 and k[0] == k[1] - 1 and k[1] == k[0]):
            ans = index
    return ans + 1

# 247 
import math

def max_edges(n):
    edges = math.floor(n * n / 4)
    return int(edges)

# 248 
def findK(n, k):
    a = []
    for i in range(1, n):
        if i % 2 == 1:
            a.append(i)
    for i in range(1, n):
        if i % 2 == 0:
            a.append(i)
    return a[k - 1]

# 249 
def isKeith(x, temp):
    terms = []
    n = 0
    while temp > 0:
        terms.append(temp % 10)
        temp = temp // 10
        n += 1
    terms.reverse()
    nextTerm = 0
    i = n
    while nextTerm < x:
        nextTerm = 0
        for j in range(1, n+1):
            nextTerm += terms[i - j]
        terms.append(nextTerm)
        i += 1
    return nextTerm == x

# 250 
def factors(n, k):
    v = []
    while n % 2 == 0:
        v.append(2)
        n = n / 2
    if len(v) >= k:
        return True
    for i in range(3,int(n**0.5)+1,2):
        while n % i== 0:
            n = n / i
            v.append(i)
        if len(v) >= k:
            return True
    if n > 2:
        v.append(n)
    if len(v) >= k:
        return True
    return False

# 251 
def separate_paren_groups(paren_string):
    all_parens = []
    current_paren = ""
    current_depth = 0
    
    for c in paren_string:
        if c == '(':
            current_depth += 1
            current_paren += c
        elif c == ')':
            current_depth -= 1
            current_paren += c
            if current_depth == 0:
                all_parens.append(current_paren)
                current_paren = ""
    
    return all_parens

# 252 
def parse_nested_paren(paren_string):
    all_levels = []
    level = 0
    max_level = 0
    for chr in paren_string:
        if chr == '(':
            level += 1
            if level > max_level:
                max_level = level
        elif chr == ')':
            level -= 1
            if level == 0:
                all_levels.append(max_level)
                max_level = 0
    return all_levels

# 253 
def filter_by_substring(strings, substring):
    result = []
    for s in strings:
        if substring in s:
            result.append(s)
    return result

# 254 
def rolling_max(numbers):
    result = []
    running_max = 0
    for n in numbers:
        if n > running_max:
            running_max = n
        result.append(running_max)
    return result

# 255 
def make_palindrome(s):
    if not s:
        return ""
    for i in range(len(s)):
        r_str = s[i:]
        if r_str == r_str[::-1]:
            n_str = s[:i]
            n2_str = n_str[::-1]
            return s + n2_str
    return s[:len(s)-1][::-1] + s[::-1]

# 256 
def stringXor(a, b):
    result = ""
    for i in range(len(a)):
        if a[i] == b[i]:
            result += '0'
        else:
            result += '1'
    return result

# 257 
def longest(strings):
    if not strings:
        return ""
    max_len = max(len(s) for s in strings)
    for s in strings:
        if len(s) == max_len:
            return s
    return ""

# 258 
def string_sequence(n):
    s = ""
    for i in range(n):
        s += str(i) + " "
    s += str(n)
    return s

# 259 
def countDistinctCharacters(s):
    distinct = set()
    for c in s.lower():
        distinct.add(c)
    return len(distinct)

# 260 
def how_many_times(s, sub):
    times = 0
    for i in range(len(s) - len(sub) + 1):
        if s[i:i+len(sub)] == sub:
            times += 1
    return times

# 261 
def sort_numbers(numbers):
    to_num = {"zero": 0, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}
    from_num = {0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine"}
    ints = []
    current = ""
    for i in range(len(numbers) + 1):
        if i == len(numbers) or numbers[i] == ' ':
            if to_num.get(current) is not None:
                ints.append(to_num.get(current))
                current = ""
        else:
            current += numbers[i]
    ints.sort()
    result = ""
    for i in range(len(ints)):
        result += from_num.get(ints[i])
        if i != len(ints) - 1:
            result += " "
    return result

# 262 
def find_closest_elements(numbers):
    closest_pair = [numbers[0], numbers[1]]
    distance = abs(numbers[0] - numbers[1])
    
    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            if abs(numbers[i] - numbers[j]) < distance:
                closest_pair[0] = numbers[i]
                closest_pair[1] = numbers[j]
                distance = abs(numbers[i] - numbers[j])
    
    closest_pair.sort()
    return closest_pair

# 263 
def rescale_to_unit(numbers):
    min_num = min(numbers)
    max_num = max(numbers)
    result = []
    for n in numbers:
        result.append((n - min_num) / (max_num - min_num))
    return result

# 264 
def filter_integers(values):
    result = []
    for e in values:
        if isinstance(e, int):
            result.append(e)
    return result

# 265 
def remove_duplicates(numbers):
    c = {}
    for i in numbers:
        c[i] = c.get(i, 0) + 1
    
    result = []
    for i in numbers:
        if c[i] == 1:
            result.append(i)
    
    return result

# 266 
def flip_case(s):
    result = ""
    for c in s:
        if c.islower():
            result += c.upper()
        else:
            result += c.lower()
    return result

# 267 
def filter_by_prefix(strings, prefix):
    result = []
    for string in strings:
        if string.startswith(prefix):
            result.append(string)
    return result

# 268 
def find_zero(xs):
    ans = 0
    value = 0
    for i in range(len(xs)):
        value += xs[i] * pow(ans, i)
    while abs(value) > 1e-6:
        driv = 0
        for i in range(1, len(xs)):
            driv += xs[i] * pow(ans, i - 1) * i
        ans -= value / driv
        value = 0
        for i in range(len(xs)):
            value += xs[i] * pow(ans, i)
    return ans

# 269 
def sort_third(l):
    thirds = []
    for i in range(0, len(l), 3):
        thirds.append(l[i])
    thirds.sort()
    result = []
    for i in range(len(l)):
        if i % 3 == 0:
            result.append(thirds[i // 3])
        else:
            result.append(l[i])
    return result

# 270 
def unique(l):
    result = list(set(l))
    result.sort()
    return result

# 271 
def max_element(l):
    return max(l)

# 272 
def triples_sum_to_zero(lst):
    for i in range(len(lst)):
        for j in range(i + 1, len(lst)):
            for k in range(j + 1, len(lst)):
                if lst[i] + lst[j] + lst[k] == 0:
                    return True
    return False

# 273 
def fib4(n):
    results = [0, 0, 2, 0]
    for i in range(4, n+1):
        results.append(results[i-4] + results[i-3] + results[i-2] + results[i-1])
    return results[n]

# 274 
def is_palindrome(text):
    pr = text[::-1]
    return pr == text

# 275 
def remove_vowels(text):
    result = ""
    vowels = "aeiou"
    for ch in text:
        if vowels.find(ch.lower()) == -1:
            result += ch
    return result

# 276 
def sameChars(s0, s1):
    set0 = set(s0)
    set1 = set(s1)
    return set0 == set1

# 277 
def common(l1, l2):
    us = set()
    for e1 in l1:
        for e2 in l2:
            if e1 == e2:
                us.add(e1)
    ret = list(us)
    ret.sort()
    return ret

# 278 
def correctBracketing(brackets):
    depth = 0
    for b in brackets:
        if b == '(':
            depth += 1
        if b == ')':
            depth -= 1
        if depth < 0:
            return False
    return depth == 0

# 279 
def circular_shift(x, shift):
    xs = str(x)
    if shift > len(xs):
        return xs[::-1]
    return xs[-shift:] + xs[:-shift]

# 280 
def search(lst):
    counter = {}
    for i in lst:
        counter[i] = counter.get(i, 0) + 1
    ans = -1
    for item in counter.items():
        if item[1] >= item[0] and item[0] > ans:
            ans = item[0]
    return ans

# 281 
def smallest_change(arr):
    ans = 0
    for i in range(len(arr) // 2):
        if arr[i] != arr[len(arr) - i - 1]:
            ans += 1
    return ans

# 282 
def total_match(lst1, lst2):
    sum1 = sum(len(st) for st in lst1)
    sum2 = sum(len(st) for st in lst2)
    return lst2 if sum1 > sum2 else lst1

# 283 
def is_happy(s):
    if len(s) < 3:
        return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

# 284 
def numerical_letter_grade(grades):
    letter_grade = []
    for gpa in grades:
        if gpa == 4.0:
            letter_grade.append("A+")
        elif gpa > 3.7:
            letter_grade.append("A")
        elif gpa > 3.3:
            letter_grade.append("A-")
        elif gpa > 3.0:
            letter_grade.append("B+")
        elif gpa > 2.7:
            letter_grade.append("B")
        elif gpa > 2.3:
            letter_grade.append("B-")
        elif gpa > 2.0:
            letter_grade.append("C+")
        elif gpa > 1.7:
            letter_grade.append("C")
        elif gpa > 1.3:
            letter_grade.append("C-")
        elif gpa > 1.0:
            letter_grade.append("D+")
        elif gpa > 0.7:
            letter_grade.append("D")
        elif gpa > 0.0:
            letter_grade.append("D-")
        else:
            letter_grade.append("E")
    return letter_grade

# 285 
def solve(n):
    biStr = ""
    sum = 0
    for c in str(n):
        sum += int(c)
    while sum > 0:
        biStr = str(sum % 2) + biStr
        sum = sum // 2
    return biStr

# 286 
def anti_shuffle(s):
    ret = ""
    current = ""
    for i in range(len(s)+1):
        if i == len(s) or s[i] == ' ':
            tmp = current
            current = ""
            if ret != "":
                ret += ' '
            ret += ''.join(sorted(tmp))
        else:
            current += s[i]
    return ret

# 287 
def sort_array(array):
    if len(array) == 0:
        return array
    if (array[0] + array[-1]) % 2 == 1:
        array.sort()
    else:
        array.sort(reverse=True)
    return array

# 288 
def encrypt(s):
    ans = ""
    for c in s:
        if c.isalpha():
            ans += chr((ord(c) - ord('a') + 4) % 26 + ord('a'))
        else:
            ans += c
    return ans

# 289 
def isBored(s):
    is_start = True
    sum = 0
    for i in range(len(s)):
        if s[i] == '.' or s[i] == '?' or s[i] == '!':
            is_start = True
        elif is_start:
            if s[i] == ' ':
                continue
            if s.startswith("I", i):
                sum += 1
            is_start = False
    return sum

# 290 
def encode(message):
    vowels = "aeiouAEIOU"
    ret = ""
    for c in message:
        if c.isupper():
            c = c.lower()
            if c not in vowels:
                c = chr(ord('a') + (ord(c) - ord('a') + 2) % 26)
        elif c.islower():
            c = c.upper()
            if c not in vowels:
                c = chr(ord('A') + (ord(c) - ord('A') + 2) % 26)
        ret += c
    return ret

# 291 
def sum_of_largest_prime(lst):
    largest = 0
    for num in lst:
        if num > largest:
            prime = True
            for i in range(2, num):
                if num % i == 0:
                    prime = False
                    break
            if prime:
                largest = num
    sum = 0
    s = str(largest)
    for i in range(len(s)):
        sum += int(s[i])
    return sum

# 292 
def check_dict_case(dict):
    if not dict:
        return False
    is_lower = 0
    is_upper = 0
    for key in dict.keys():
        for c in key:
            if c.islower():
                is_lower = 1
            elif c.isupper():
                is_upper = 1
            else:
                return False
    return is_lower + is_upper == 1

# 293 
def multiply(a, b):
    return abs(a) % 10 * abs(b) % 10

# 294 
def count_upper(s):
    u_vowel = "AEIOU"
    count = 0
    for i in range(0, len(s), 2):
        if u_vowel.index(s[i]) != -1:
            count += 1
    return count

# 295 
def by_length(arr):
    num_to = {1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"}
    sorted_arr = sorted(arr, reverse=True)
    new_arr = []
    for n in sorted_arr:
        if n >= 1 and n <= 9:
            new_arr.append(num_to[n])
    return new_arr

# 296 
def f(n):
    sum = 0
    prod = 1
    result = []
    for i in range(1, n+1):
        sum += i
        prod *= i
        if i % 2 == 0:
            result.append(prod)
        else:
            result.append(sum)
    return result

# 297 
def even_odd_palindrome(n):
    even_count = 0
    odd_count = 0
    for i in range(1, n+1):
        s = str(i)
        r_str = s[::-1]
        if s == r_str:
            if i % 2 == 1:
                odd_count += 1
            else:
                even_count += 1
    return [even_count, odd_count]

# 298 
def histogram(test):
    count = {}
    max = 0
    for i in range(len(test)):
        if test[i] != ' ':
            count[test[i]] = count.get(test[i], 0) + 1
            if count[test[i]] > max:
                max = count[test[i]]
    result = {}
    for item in count.items():
        if item[1] == max:
            result[item[0]] = item[1]
    return result

# 299 
def reverse_delete(s, c):
    ret = ""
    for ch in s:
        if c.find(ch) == -1:
            ret += ch
    flag = "False"
    if ret == ret[::-1]:
        flag = "True"
    return [ret, flag]

# 300 
def sort_array(arr):
    bin = []
    for i in arr:
        b = 0
        n = abs(i)
        while n > 0:
            b += n % 2
            n //= 2
        bin.append(b)

    for i in range(len(arr)):
        for j in range(1, len(arr)):
            if bin[j] < bin[j - 1] or (bin[j] == bin[j - 1] and arr[j] < arr[j - 1]):
                bin[j], bin[j - 1] = bin[j - 1], bin[j]
                arr[j], arr[j - 1] = arr[j - 1], arr[j]
    return arr

# 301 
def get_closest_vowel(word):
    vowels = "AEIOUaeiou"
    for i in range(len(word) - 2, 0, -1):
        if (vowels.index(word[i]) != -1 and vowels.index(word[i + 1]) == -1 and vowels.index(word[i - 1]) == -1):
            return word[i]
    return ""

# 302 
def match_parens(lst):
    strings = [lst[0] + lst[1], lst[1] + lst[0]]
    for s in strings:
        count = 0
        for c in s:
            if c == '(':
                count += 1
            else:
                count -= 1
            if count < 0:
                break
        if count == 0:
            return "Yes"
    return "No"

# 303 
def maximum(arr, k):
    if k == 0:
        return []
    arr.sort()
    return arr[-k:]

# 304 
def valid_date(date):
    if len(date) != 10:
        return False
    for i in range(10):
        if i == 2 or i == 5:
            if date[i] != '-':
                return False
        elif not date[i].isdigit():
            return False
    month = int(date[:2])
    day = int(date[3:5])
    year = int(date[6:10])
    if month < 1 or month > 12:
        return False
    if day < 1 or day > 31:
        return False
    if day == 31 and (month == 4 or month == 6 or month == 9 or month == 11 or month == 2):
        return False
    if day == 30 and month == 2:
        return False
    return True

# 305 
def split_words(txt):
    current = ""
    result = []
    if ' ' in txt:
        for i in range(len(txt) + 1):
            if i == len(txt) or txt[i] == ' ':
                if len(current) > 0:
                    result.append(current)
                current = ""
            else:
                current += txt[i]
        return result
    if ',' in txt:
        for i in range(len(txt) + 1):
            if i == len(txt) or txt[i] == ',':
                if len(current) > 0:
                    result.append(current)
                current = ""
            else:
                current += txt[i]
        return result
    num = 0
    for c in txt:
        if c.islower() and ord(c) % 2 == 0:
            num += 1
    return [str(num)]

# 306 
def tri(n):
    if n == 0:
        return [1]
    tris = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            tris.append(i // 2 + 1)
        else:
            tris.append(tris[i - 1] + tris[i - 2] + (i + 3) // 2)
    return tris

# 307 
def check_if_last_char_is_a_letter(txt):
    if len(txt) == 0:
        return False
    return txt[-1].isalpha() and (len(txt) == 1 or not txt[-2].isalpha())

# 308 
def order_by_points(nums):
    result = []
    for num in nums:
        w = str(abs(num))
        sum = 0
        for c in w:
            sum += ord(c) - ord('0')
        if num < 0:
            sum -= 2 * (ord(w[0]) - ord('0'))
        result.append(sum)
    
    for i in range(len(nums)):
        for j in range(i+1, len(nums)):
            if result[j-1] > result[j]:
                result[j-1], result[j] = result[j], result[j-1]
                nums[j-1], nums[j] = nums[j], nums[j-1]
    
    return nums

# 309 
def bf(planet1, planet2):
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    idx1 = planets.index(planet1)
    idx2 = planets.index(planet2)
    if idx1 == -1 or idx2 == -1 or idx1 == idx2:
        return []
    return planets[idx1+1:idx2] if idx1 < idx2 else planets[idx2+1:idx1]

# 310 
def sorted_list_sum(lst):
    result = []
    for i in lst:
        if len(i) % 2 == 0:
            result.append(i)
    result.sort(key=lambda x: (len(x), x))
    return result

# 311 
def cycpatternCheck(a, b):
    for i in range(len(b)+1):
        rotate = b[i:] + b[:i]
        if a in rotate:
            return True
    return False

# 312 
def even_odd_count(num):
    even_count = 0
    odd_count = 0
    for i in str(abs(num)):
        if int(i) % 2 == 0:
            even_count += 1
        else:
            odd_count += 1
    return [even_count, odd_count]

# 313 
def find_max(words):
    max = ""
    max_length = 0
    for word in words:
        unique = set(word)
        if len(unique) > max_length or (len(unique) == max_length and word < max):
            max = word
            max_length = len(unique)
    return max

# 314 
def solve(s):
    no_letter = True
    result = ""
    for ch in s:
        if ch.isupper():
            ch = ch.lower()
            no_letter = False
        elif ch.islower():
            ch = ch.upper()
            no_letter = False
        result += ch
    if no_letter:
        return result[::-1]
    else:
        return result

# 315 
def most_frequent(arr, n):
    hp = {}
    for i in range(n):
        if arr[i] in hp:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
    maxCount = 0
    res = -1
    for key, value in hp.items():
        if maxCount < value:
            res = key
            maxCount = value
    return res

# 316 
def find(a, b, k, n, n2):
    s = set()
    for i in range(n2):
        s.add(b[i])
    missing = 0
    for i in range(n1):
        if a[i] not in s:
            missing += 1
        if missing == k:
            return a[i]
    return -1

# 317 
def solve_query(start, end, arr):
    mp = {}
    for i in range(start, end+1):
        mp[arr[i]] = mp.get(arr[i], 0) + 1
    count = 0
    for entry in mp.items():
        if entry[0] == entry[1]:
            count += 1
    return count

# 318 
def segregate(arr, size):
    j = 0
    for i in range(size):
        if arr[i] <= 0:
            arr[i], arr[j] = arr[j], arr[i]
            j += 1
    return j

# 319 
def countTriplets(a, n):
    s = set()
    for i in range(n):
        s.add(a[i])
    count = 0
    for i in range(n):
        for j in range(i + 1, n):
            xr = a[i] ^ a[j]
            if (xr in s) and (xr != a[i]) and (xr != a[j]):
                count += 1
    return count // 3

# 320 
def least_frequent(arr, n):
    hp = {}
    for i in range(n):
        if arr[i] in hp:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
    min_count = n + 1
    res = -1
    for key, value in hp.items():
        if min_count >= value:
            res = key
            min_count = value
    return res

# 321 
def find_permutations(arr):
    cnt = 0
    max_ind = -1
    min_ind = 10000000
    n = len(arr)
    index_of = {}
    for i in range(n):
        index_of[arr[i]] = i + 1
    for i in range(1, n + 1):
        max_ind = max(max_ind, index_of.get(i, 0))
        min_ind = min(min_ind, index_of.get(i, 0))
        if max_ind - min_ind + 1 == i:
            cnt += 1
    return cnt

# 322 
def formQuadruplets(arr, n):
    pairs = n // 4
    arr.sort(reverse=True)
    ans = 0
    for i in range(0, n - pairs, 3):
        ans += arr[i + 2]
    return ans

# 323 
def lexicographically_maximum(s, n):
    m = {}
    for i in range(n):
        if s[i] in m:
            m[s[i]] += 1
        else:
            m[s[i]] = 1
    
    v = []
    for i in range(ord('a'), ord('a') + min(n, 25)):
        if chr(i) not in m:
            v.append(chr(i))
    
    j = len(v) - 1
    for i in range(n):
        if s[i] >= chr(ord('a') + min(n, 25)) or (s[i] in m and m[s[i]] > 1):
            if v[j] < s[i]:
                continue
            m[s[i]] -= 1
            s = s[:i] + v[j] + s[i+1:]
            j -= 1
        if j < 0:
            break
    
    l = 0
    for i in range(n-1, -1, -1):
        if l > j:
            break
        if s[i] >= chr(ord('a') + min(n, 25)) or (s[i] in m and m[s[i]] > 1):
            m[s[i]] -= 1
            s = s[:i] + v[l] + s[i+1:]
            l += 1
    
    return s

# 324 
def noOfValidKbers(k, arr):
    s = set()
    while k != 0:
        s.add(k % 10)
        k = k // 10
    count = 0
    for i in range(len(arr)):
        no = arr[i]
        flag = True
        while no != 0:
            digit = no % 1
            if digit not in s:
                flag = False
                break
            no = no // 10
        if flag:
            count += 1
    return count

# 325 
def delCost(s, cost):
    ans = 0
    forMax = {}
    forTot = {}
    for i in range(len(s)):
        if s[i] not in forMax:
            forMax[s[i]] = cost[i]
        else:
            forMax[s[i]] = max(cost[i], forMax[s[i]])
            
        if s[i] not in forTot:
            forTot[s[i]] = cost[i]
        else:
            forTot[s[i]] += cost[i]
            
    for i in forMax.items():
        ans += forTot[i[0]] - i[1]
        
    return ans

# 326 
def replace_duplicates(names):
    hash = {}
    for i in range(len(names)):
        if names[i] not in hash:
            hash[names[i]] = 1
        else:
            count = hash[names[i]]
            hash[names[i]] = count + 1
            names[i] = names[i] + str(count)
    return names

# 327 
def minmax_numbers(matrix, res):
    set_ = set()
    for i in range(len(matrix)):
        min_r = float('inf')
        for j in range(len(matrix[i])):
            min_r = min(min_r, matrix[i][j])
        set_.add(min_r)
    for j in range(len(matrix[0])):
        max_c = float('-inf')
        for i in range(len(matrix)):
            max_c = max(max_c, matrix[i][j])
        if max_c in set_:
            res.append(max_c)
    return res

# 328 
def lengthOfLongestAP(a, n):
    dp = {}
    res = 2
    for i in range(n):
        for j in range(i+1, n):
            d = a[j] - a[i]
            if d in dp:
                if a[i] in dp[d]:
                    dp[d][a[i]] += 1
                else:
                    dp[d][a[i]] = 2
            else:
                dp[d] = {a[i]: 2}
            res = max(res, dp[d][a[i]])
    return res

# 329 
def findKthChar(n, k):
    string = "A"
    for j in range(2, n+1):
        temp = ""
        for i in range(len(string)):
            if string[i] == 'A':
                temp = string[:i] + 'B' + string[i+1:]
            else:
                temp = string[:i] + 'A' + string[i+1:]
        string = temp[::-1]
        string += temp
    return string[k-1]

# 330 
def find_kth_largest(s, k):
    tmp = sorted(s, reverse=True)
    return tmp[k - 1]

# 331 
def subArraylen(arr, n, k):
    mp = {}
    mp[arr[0]] = 0
    for i in range(1, n):
        arr[i] = arr[i] + arr[i - 1]
        mp[arr[i]] = i
    len = float('inf')
    for i in range(n):
        if arr[i] < k:
            continue
        else:
            x = arr[i] - k
            if x == 0:
                len = min(len, i)
            elif x in mp:
                len = min(len, i - mp[x])
    return len

# 332 
def find_max_len(a, k):
    n = len(a)
    a.sort()
    vis = [False] * n
    mp = {}
    for i in range(n):
        mp[a[i]] = i
    c = 0
    for i in range(n):
        if not vis[i]:
            check = a[i] * k
            if mp.get(check) is not None:
                c += 1
                vis[mp[check]] = True
    return n - c

# 333 
def minDistancePoints(a, k, n):
    m = {}
    q = []
    for i in range(n):
        m[a[i]] = 1
        q.append(a[i])
    ans = []
    while k > 0:
        x = q.pop(0)
        if x - 1 not in m and k > 0:
            m[x - 1] = 1
            q.append(x - 1)
            ans.append(x - 1)
            k -= 1
        if x + 1 not in m and k > 0:
            m[x + 1] = 1
            q.append(x + 1)
            ans.append(x + 1)
            k -= 1
    return ans

# 334 
def isValidLen(s, len, k):
    n = len(s)
    mp = {}
    right = 0
    while right < len:
        if s[right] in mp:
            mp[s[right]] += 1
        else:
            mp[s[right]] = 1
        right += 1
        if len(mp) <= k:
            return True
    
    while right < n:
        if s[right] in mp:
            mp[s[right]] += 1
        else:
            mp[s[right]] = 1
        if s[right - len] in mp:
            mp[s[right - len]] -= 1
            if mp[s[right - len]] == 0:
                del mp[s[right - len]]
        if len(mp) <= k:
            return True
        right += 1
    return len(mp) <= k

# 335 
def partition(arr, low, high):
    pivot = arr[high]
    i = low - 1
    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1

# 336 
def str_score(strs, s, n):
    m = {}
    for i in range(n):
        m[strs[i]] = i + 1
    if s not in m:
        return 0
    score = 0
    for i in range(len(s)):
        score += ord(s[i]) - ord('a') + 1
    score = score * m[s]
    return score

# 337 
def countEle(s, a, n):
    mp = {}
    ans = []
    for i in range(n):
        num = a[i]
        if num in mp:
            ans.append(0)
        else:
            cnt = 0
            while s[0] != num:
                mp[s[0]] = True
                s.remove(s[0])
                cnt += 1
            s.remove(s[0])
            cnt += 1
            ans.append(cnt)
    return ans

# 338 
def maxDistinctChar(s, n, k):
    freq = {}
    for i in range(n):
        if s[i] in freq:
            freq[s[i]] += 1
        else:
            freq[s[i]] = 1
    v = []
    for key, value in freq.items():
        v.append(value)
    v.sort()
    for i in range(len(v)):
        mn = min(v[i] - 1, k)
        v[i] -= mn
        k -= mn
    if k > 0:
        for i in range(len(v)):
            mn = min(v[i], k)
            v[i] -= mn
            k -= mn
    res = 0
    for i in range(len(v)):
        if v[i] == 1:
            res += 1
    return res

# 339 
def findKth(arr, n, k):
    missing = set()
    count = 0
    for i in range(n):
        missing.add(arr[i])
    maxM = max(arr)
    minM = min(arr)
    for i in range(minM + 1, maxM):
        if i not in missing:
            count += 1
        if count == k:
            return i
    return -1

# 340 
def almostSort(a, n):
    for i in range(n - 1):
        if a[i] > a[i + 1]:
            a[i], a[i + 1] = a[i + 1], a[i]
            i += 1
    for i in range(n - 1):
        if a[i] > a[i + 1]:
            return False
    return True

# 341 
def maximumSum(s, n, k):
    sum = 0
    freq = [0] * 256
    for i in range(n):
        freq[ord(s[i])] += 1
    freq.sort(reverse=True)
    for i in range(256):
        if k > freq[i]:
            sum += freq[i] * freq[i]
            k -= freq[i]
        else:
            sum += freq[i] * k
            break
    return sum

# 342 
def findMinOperations(arr, N, K):
    operations = 0

    for i in range(K):
        freq = {}

        for j in range(i, N, K):
            if arr[j] in freq:
                freq[arr[j]] += 1
            else:
                freq[arr[j]] = 1

        max1 = 0
        num = 0

        for key, value in freq.items():
            if value > max1:
                max1 = value
                num = key

        for key, value in freq.items():
            if key != num:
                operations += value

    return operations

# 343 
def sub_string(s, n):
    v = []
    for i in range(n):
        for len in range(n - i):
            find = s[i:i+len+1]
            v.append(find)
    return v

# 344 
def checkUniqueFrequency(arr, n):
    freq = {}
    for i in range(n):
        freq[arr[i]] = freq.get(arr[i], 0) + 1
    uniqueFreq = set()
    for entry in freq.items():
        if entry[1] in uniqueFreq:
            return False
        else:
            uniqueFreq.add(entry[1])
    return True

# 345 
def minCost(str1, str2, n):
    cost = 0
    tmp = list(str1)
    
    for i in range(n):
        if tmp[i] != str2[i]:
            if i < n - 1 and tmp[i + 1] != str2[i]:
                tmp[i], tmp[i + 1] = tmp[i + 1], tmp[i]
                cost += 1
            else:
                cost += 1
    return cost

# 346 
def isValidNum(x):
    mp = {}
    for i in range(len(x)):
        if mp.get(ord(x[i]) - ord('0')):
            return False
        elif ord(x[i]) - ord('0') > 5:
            return False
        else:
            mp[ord(x[i]) - ord('0')] = 1
    return True

# 347 
def minimizeDiff(arr, n, k):
    max_val = max(arr)
    min_val = min(arr)
    
    if max_val - min_val <= k:
        return max_val - min_val
    
    avg = (max_val + min_val) // 2
    
    for i in range(n):
        if arr[i] > avg:
            arr[i] = arr[i] - k
        else:
            arr[i] = arr[i] + k
    
    max_val = max(arr)
    min_val = min(arr)
    
    return max_val - min_val

# 348 
def getMinCost(arr, n):
    min_ele = min(arr)
    return min_ele * (n - 1)

# 349 
def possibility(m, length, s):
    countOdd = 0
    for i in range(length):
        if (m.get(s[i]) - 0) % 2 != 0:
            countOdd += 1
        if countOdd > 1:
            return False
    return True

# 350 
def minimumCostOfBreaking(x, y, m, n):
    res = 0
    x.sort(reverse=True)
    y.sort(reverse=True)
    hzntl = 1
    vert = 1
    i = 0
    j = 0
    while i < m and j < n:
        if x[i] > y[j]:
            res += x[i] * vert
            hzntl += 1
            i += 1
        else:
            res += y[j] * hzntl
            vert += 1
            j += 1
    total = 0
    while i < m:
        total += x[i]
        i += 1
    res += total * vert
    total = 0
    while j < n:
        total += y[j]
        j += 1
    res += total * hzntl
    return res

# 351 
def find_maximum_score(a, n):
    freq = {}
    for i in range(n):
        if a[i] in freq:
            freq[a[i]] += 1
        else:
            freq[a[i]] = 1
    dp = [0] * (max(a) + 1)
    dp[0] = 0
    dp[1] = freq.get(1, 0)
    for i in range(2, len(dp)):
        dp[i] = max(dp[i-1], dp[i-2] + freq.get(i, 0) * i)
    return dp[-1]

# 352 
def countWays(s, t, k, mod):
    n = len(s)
    a = 0
    b = 0
    for i in range(n):
        p = s[i:] + s[:i]
        if p == t:
            a += 1
        else:
            b += 1
    dp1 = [0] * (k + 1)
    dp2 = [0] * (k + 1)
    if s == t:
        dp1[0] = 1
        dp2[0] = 0
    else:
        dp1[0] = 0
        dp2[0] = 1
    for i in range(1, k + 1):
        dp1[i] = (dp1[i - 1] * (a - 1) % mod + dp2[i - 1] * a % mod) % mod
        dp2[i] = (dp1[i - 1] * b % mod + dp2[i - 1] * (b - 1) % mod) % mod
    return dp1[k]

# 353 
def findSubarraySum(arr, n, k):
    prevSum = {}
    res = 0
    currSum = 0
    for i in range(n):
        currSum += arr[i]
        if currSum == k:
            res += 1
        if currSum - k in prevSum:
            res += prevSum[currSum - k]
        prevSum[currSum] = prevSum.get(currSum, 0) + 1
    return res

# 354 
def maximumOccurrence(s):
    n = len(s)
    freq = {}
    i, j = 0, 0
    for i in range(n):
        temp = ""
        temp += s[i]
        freq[temp] = freq.get(temp, 0) + 1
    for i in range(n):
        for j in range(i+1, n):
            temp = ""
            temp += s[i]
            temp += s[j]
            freq[temp] = freq.get(temp, 0) + 1
    answer = float('-inf')
    for entry in freq.items():
        answer = max(answer, entry[1])
    return answer

# 355 
def count_characters(strings, chars):
    res = 0
    freq = {}
    for i in range(len(chars)):
        freq[chars[i]] = freq.get(chars[i], 0) + 1
    for st in strings:
        flag = True
        for c in st:
            if c not in freq:
                flag = False
                break
        if flag:
            res += len(st)
    return res

# 356 
def distinctSubstring(p, q, k, n):
    ss = set()
    for i in range(n):
        sum = 0
        s = ""
        for j in range(i, n):
            pos = ord(p[j]) - ord('a')
            sum += int(q[pos])
            s += p[j]
            if sum <= k:
                ss.add(s)
            else:
                break
    return len(ss)

# 357 
def uniqueMorseRep(arr):
    morseCode = [ ".-" , "-..." , "-.-." , "-.." , "." , "..-." , "--." , "...." , ".." , ".---" , "-.-" , ".-.." , "--" , "-." , "---" , ".--." , "--.-" , ".-." , "..." , "-" , "..-" , "...-" , ".--" , "-..-" , "-.--" , "--.." ]
    st = set()
    n = len(arr)
    for i in range(n):
        temp = ""
        m = len(arr[i])
        for j in range(m):
            temp += morseCode[ord(arr[i][j]) - ord('a')]
        st.add(temp)
    return len(st)

# 358 
def countSubstrings(st, k):
    n = len(st)
    answer = 0
    map = {}
    for i in range(k):
        if st[i] not in map:
            map[st[i]] = 1
        else:
            map[st[i]] += 1
    if len(map) == k:
        answer += 1
    for i in range(k, n):
        if st[i] not in map:
            map[st[i]] = 1
        else:
            map[st[i]] += 1
        map[st[i-k]] -= 1
        if map[st[i-k]] == 0:
            del map[st[i-k]]
        if len(map) == k:
            answer += 1
    return answer

# 359 
def can_construct(s, k):
    m = {}
    p = 0
    if len(s) == k:
        return True
    for i in range(len(s)):
        m[s[i]] = m.get(s[i], 0) + 1
    if k > len(s):
        return False
    else:
        for h in m.items():
            if h[1] % 2 != 0:
                p = p + 1
        if k < p:
            return False
    return True

# 360 
def equalIgnoreCase(str1, str2):
    str1 = str1.upper()
    str2 = str2.upper()
    return str1 == str2

# 361 
def findLongestSub(bin):
    n = len(bin)
    i = 0
    sum = 0
    prevSum = {}
    maxLen = 0
    
    for i in range(n):
        if bin[i] == '1':
            sum += 1
        else:
            sum -= 1
        
        if sum > 0:
            maxLen = i + 1
        elif sum <= 0 and (sum - 1) in prevSum:
            currLen = i - prevSum[sum - 1]
            maxLen = max(maxLen, currLen)
        
        if sum not in prevSum:
            prevSum[sum] = i
    
    return maxLen

# 362 
def hasAllCodes(s, k):
    us = set()
    for i in range(len(s) - k + 1):
        us.add(s[i:i+k])
    return len(us) == 2**k

# 363 
def checkPalin(word):
    n = len(word)
    word = word.lower()
    for i in range(n):
        if word[i] != word[n-1]:
            return False
        n -= 1
    return True

# 364 
def convert(st):
    w = ""
    z = ""
    st = st.upper() + " "
    for i in range(len(st)):
        ch = st[i]
        if ch != ' ':
            w += ch
        else:
            z += w[0].lower() + w[1:] + " "
            w = ""
    return z

# 365 
def max_lines(n, x, y1, x2, y2):
    s = set()
    slope = 0
    for i in range(n):
        if x[i] == x2[i]:
            slope = float('inf')
        else:
            slope = (y2[i] - y1[i]) / float(x2[i] - x[i])
        s.add(slope)
    return len(s)

# 366 
def prime_factor(n):
    primef = {}
    while n % 2 == 0:
        if 2 in primef:
            primef[2] += 1
        else:
            primef[2] = 1
        n //= 2
    for i in range(3, int(n**0.5)+1, 2):
        while n % i== 0:
            if i in primef:
                primef[i] += 1
            else:
                primef[i] = 1
            n //= i
    if n > 2:
        primef[n] = 1
    return primef

# 367 
def isDivisibleByDivisor(s, d):
    s %= d
    hashSet = set()
    hashSet.add(s)
    for i in range(d):
        s += s % d
        s %= d
        if s in hashSet:
            if s == 0:
                return "Yes"
            return "No"
        else:
            hashSet.add(s)
    return "Yes"

# 368 
def oddSum(a, n, k):
    odd = set()
    even = set()
    for i in range(n):
        if a[i] % 2 == 0:
            even.add(a[i])
        else:
            odd.add(a[i])
    if len(odd) >= k:
        return True
    flag = False
    for i in range(1, k, 2):
        needed = k - i
        if needed <= len(even):
            return True
    return flag

# 369 
def day_of_year(date):
    days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    year = int(date[:4])
    month = int(date[5:7])
    day = int(date[8:])
    
    if month > 2 and (year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)):
        day += 1
    
    while month > 1:
        day += days[month - 2]
        month -= 1
    
    return day

# 370 
def isPerfectSquare(arr, n):
    umap = {}
    for i in range(n):
        umap[arr[i]] = umap.get(arr[i], 0) + 1
    for itr in umap.items():
        if itr[1] % 2 == 1:
            return False
    return True

# 371 
def minMoves(n):
    s = str(n)
    ans = float('inf')
    length = len(s)
    
    for i in range(length):
        for j in range(length):
            if i == j:
                continue
            
            t = list(s)
            cur = 0
            
            for k in range(i, length - 1):
                c = t[k]
                t[k] = t[k + 1]
                t[k + 1] = c
                cur += 1
            
            for k in range(j - (j > i) , length - 2):
                c = t[k]
                t[k] = t[k + 1]
                t[k + 1] = c
                cur += 1
            
            pos = -1
            
            for k in range(length):
                if t[k] != '0':
                    pos = k
                    break
            
            for k in range(pos, 0, -1):
                c = t[k]
                t[k] = t[k - 1]
                t[k - 1] = c
                cur += 1
            
            nn = int(''.join(t))
            
            if nn % 25 == 0:
                ans = min(ans, cur)
    
    if ans == float('inf'):
        return -1
    
    return ans

# 372 
def minimumOperations(a, n):
    mp = {}
    for i in range(n):
        mp[a[i]] = mp.get(a[i], 0) + 1
    count = 0
    for entry in mp.items():
        if entry[1] > 1:
            count += entry[1] - 1
    return count

# 373 
def kaprekarRec(n, prev):
    if n == 0:
        return 0
    prev = n
    digits = [0] * 4
    for i in range(4):
        digits[i] = n % 10
        n = n // 10
    digits.sort()
    asc = 0
    for i in range(4):
        asc = asc * 10 + digits[i]
    digits.sort(reverse=True)
    desc = 0
    for i in range(3, -1, -1):
        desc = desc * 10 + digits[i]
    diff = abs(asc - desc)
    if diff == prev:
        return diff
    return kaprekarRec(diff, prev)

# 374 
def fractionToDecimal(numr, denr):
    res = ""
    mp = {}
    rem = numr % denr
    while rem != 0 and not mp.get(rem):
        mp[rem] = res.length()
        rem = rem * 10
        resPart = rem // denr
        res += str(resPart)
        rem = rem % denr
    if rem == 0:
        return ""
    if mp.get(rem):
        return res[mp[rem]:]
    return ""

# 375 
def isFancy(num):
    fp = {'0': '0', '1': '1', '6': '9', '8': '8', '9': '6'}
    n = len(num)
    l = 0
    r = n - 1
    while l <= r:
        if not fp.get(num[l]) or fp.get(num[l]) != num[r]:
            return False
        l += 1
        r -= 1
    return True

# 376 
def distinct_odd_ratio(numbers):
    distinct_count = len(set(numbers))
    distinct_odd_count = len([num for num in set(numbers) if num % 2 == 1])
    return distinct_odd_count / distinct_count

# 377 
def compare_sum(numbers, words):
    int_sum = sum(numbers)
    word_length_sum = sum(len(word) for word in words)
    if int_sum < word_length_sum:
        return -1
    elif int_sum > word_length_sum:
        return 1
    else:
        return 0

# 378 
def all_longer_than(short_words, long_words):
    max_of_short = max(len(word) for word in short_words)
    min_of_long = min(len(word) for word in long_words)
    return min_of_long > max_of_short

# 379 
def compare_odd_even_range(numbers):
    range_odd = max(numbers) - min(numbers)
    range_even = max(num for num in numbers if num % 2 == 0) - min(num for num in numbers if num % 2 == 0)
    
    if range_odd < range_even:
        return -1
    elif range_odd > range_even:
        return 1
    else:
        return 0

# 380 
def average_distinct_length(words):
    average_len = sum(len(word) for word in set(words)) / len(set(words))
    return average_len

# 381 
def withDrawBalance(start, withdrawals):
    end = start
    for nextWithdrawal in withdrawals:
        if nextWithdrawal <= end:
            end = end - nextWithdrawal
        else:
            break
    return end

# 382 
def first_short_and_starts_with_o(words):
    matched_element = next((word for word in words if len(word) < 5 and word[0] == 'o'), "")
    return matched_element

# 383 
def big_number_at_index(numbers, index):
    target_num = next((x for x in numbers if x > 5), None)
    return target_num

# 384 
import math

def contains_square_in_range(range_start, range_length):
    contains_square = any(math.pow(int(math.sqrt(n)), 2) == n for n in range(range_start, range_start + range_length))
    return contains_square

# 385 
from collections import defaultdict

def group_numbers_by_mod(numbers, mod):
    number_groups = defaultdict(list)
    for num in numbers:
        number_groups[num % mod].append(num)
    return dict(number_groups)

# 386 
def group_words_by_first_char(words):
    word_groups = {}
    for word in words:
        first_char = word[0]
        if first_char in word_groups:
            word_groups[first_char].append(word)
        else:
            word_groups[first_char] = [word]
    return word_groups

# 387 
def order_by_length_and_descending(words):
    sorted_words = sorted(words, key=lambda word: (len(word), word), reverse=True)
    return sorted_words

# 388 
def order_first_char_descending_reverse(words):
    sorted_words = sorted(words, key=lambda w: w[0], reverse=True)
    sorted_words.reverse()
    return sorted_words

# 389 
def get_sub_list_of_negative(numbers, start, length):
    sub_list = [num for num in numbers[start:] if num < 0][:length]
    return sub_list

# 390 
def get_positive_sequence(numbers):
    sub_sequence = [n for n in numbers if n >= 0]
    return sub_sequence

# 391 
def get_larger_than_index_sequence(numbers):
    sub_sequence = [num for i, num in enumerate(numbers) if num >= i]
    return sub_sequence

# 392 
def rearrange_word_by_indexes(words, indexes):
    new_indexes = [n % len(words) for n in indexes if n >= len(words)]
    new_words = [words[n] for n in new_indexes]
    return new_words

# 393 
def get_words_upper_lower(words):
    upper_lower_words = [[word.upper(), word.lower()] for word in words]
    return upper_lower_words

# 394 
def select_if_in_place(numbers):
    nums_in_place = [numbers[i] == i for i in range(len(numbers))]
    return nums_in_place

# 395 
def select_pairs(numbers_a, numbers_b):
    pairs = [ [a, b] for a in numbers_a for b in numbers_b if a < b ]
    return pairs

# 396 
def string_cross_join(end_words, begin_words):
    cross_strings = [e + " " + b for b in begin_words for e in end_words if e[-1] == b[0]]
    return cross_strings

# 397 
def elements_contain_subword(words, subword):
    if words[:5].all(lambda w: subword in w):
        return 1
    elif words[:5].any(lambda w: subword in w):
        return 0
    else:
        return -1

# 398 
def concat_large_numbers(numbers_a, numbers_b, flag):
    all_numbers = [n for n in numbers_a + numbers_b if n > flag]
    return all_numbers

# 399 
def DotProduct(vectorA, vectorB):
    dotProduct = sum(vectorA[i] * vectorB[i] for i in range(len(vectorA)))
    return dotProduct

# 400 
def SetDifference(setA, setB):
    difference = list(setA)
    difference.addAll(setB)
    intersection = list(setA)
    intersection.retainAll(setB)
    difference.removeAll(intersection)
    difference.sort()
    return difference

# 401 


