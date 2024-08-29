# 1 
def greatest_common_divisor(a, b):
    if a == 0 or b == 0:
        return a + b
    elif a == b:
        return a
    elif a > b:
        return greatest_common_divisor(a % b, b)
    else:
        return greatest_common_divisor(a, b % a)

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
def fizz_buzz(n):
    count = 0
    for i in range(1, n):
        if i % 15 == 0 or i % 13 == 0:
            q = i
            while q > 0:
                if q % 10 == 7:
                    count += 1
                q /= 10
    return count

# 5 
def primeFib(n):
    f0, f1 = 0, 1
    while n > 0:
        p = f0 + f1
        is_prime = p >= 2
        for i in range(2, p):
            if p % i == 0:
                is_prime = False
                break
        if is_prime:
            n -= 1
        f0, f1 = f1, p
    return f1

# 6 
def triangle_area(a, h):
    return a * h / 2

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
    elif n == 1:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

# 10 
def largest_prime_factor(n): 
    i = 2
    while i < n:
        while n % i == 0 and n > i:
            n /= i
    return n

# 11 
def sum_to_n(n):
    result = 0
    for i in range(1, n+1):
        result += i
    return result

# testing
print(sum_to_n(5)) # should print 15
print(sum_to_n(10)) # should print 55
print(sum_to_n(0))  # should print 0

# 12 
def fibfib(n):
    if n == 0:
        return 0
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return fibfib(n - 1) + fibfib(n - 2) + fibfib(n - 3)

# 13 
def is_multiply_prime(a):
    num = 0
    for i in range(2, a + 1):
        while a % i == 0 and a >= i:
            a /= i
            num += 1
    return num == 3

# 14 
def is_simple_power(x, n):
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
    elif y % 2 == 0:
        return y
    elif x == y:
        return -1
    else:
        return y - 1

# 16 
def is_equal_to_sum_of_even(n):
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
def x_or_y(n, x, y):
    def is_prime(num):
        if num < 2:
            return False
        for i in range(2, num):
            if num % i == 0:
                return False
        return True

    if is_prime(n):
        return x
    return y

# 19 
def rightAngleTriangle(a, b, c):
    return a*a == b*b + c*c or b*b == a*a + c*c or c*c == a*a + b*b

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
def is_palindrome(s):
    l = len(s) // 2
    for i in range(l):
        if s[i] != s[-i - 1]:
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
def get_next_gap(gap):
    gap = gap * 10 / 13
    if gap < 1:
        return 1
    return gap

# 24 
def countNonDecreasing(n):
    k = 10
    count = 1
    for i in range(1, n+1):
        count *= k + i - 1
        count /= i
    return count

# 25 
def power(x, y): 
    if y == 0: 
        return 1 
    elif y % 2 == 0: 
        return power(x, y/2) * power(x, y/2) 
    else: 
        return x * power(x, y/2) * power(x, y/2)

# 26 
def power(x, y): 
    if y == 0: 
        return 1 
    temp = power(x, y / 2) 
    if y % 2 == 0: 
        return temp * temp 
    else: 
        if y > 0: 
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
        return - multiply(x, -y)

# 28 
def smallest(x, y, z):
    if y / x == 0:
        return y / z == 0 if y else z
    return x / z == 0 if x else z

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
    if m == 1:
        return 0
    while a > 1:
        q = a // m
        t = m
        m = a % m
        a = t
        t = x0
        x0 = x1 - q * x0
        if x1 < 0:
            x1 += m0
    return x1

# 31 
def count_rotations(s, n):
    s2 = s + s
    pre = [2 * n]
    for i in range(2*n):
        if i != 0:
            pre[i] += pre[i - 1]
        if s2[i] == 'a' or s2[i] == 'e' or s2[i] == 'i' or s2[i] == 'o' or s2[i] == 'u':
            pre[i] += 1
    ans = 0
    for i in range(n - 1, 2 * n - 1):
        r = i
        l = i - n
        x1 = pre[r]
        if l >= 0:
            x1 -= pre[l]
        r = i - n // 2
        left = pre[r]
        if l >= 0:
            left -= pre[l]
        right = x1 - left
        if left > right:
            ans += 1
    return ans

# 32 
def binomialCoeff(n, k):
    res = 1
    if k > n - k:
        k = n - k
    for i in range(k):
        res *= n - i
        res /= i + 1
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
    for i in range(0, n):
        if i <= last_zero and s[i] == '0':
            ans += s[i]
        elif i > last_zero:
            ans += s[i]
    return ans

# 35 
def calculate_max(n, m, k):
    ans = -1
    low = 0
    high = m
    while low <= high:
        mid = (low + high) // 2
        val = 0
        l = k - 1
        r = n - k
        val += mid * (2 * mid - l) / 2 if mid >= l else val += mid * (mid - 1) / 2 + (l - mid)
        if mid >= r: val += r * (2 * mid - r - 1) / 2
        else: val += mid * (mid - 1) / 2 + (r - mid)
        if val <= m: ans = max(ans, mid)
        else: high = mid - 1
        low = mid + 1
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
def check_reverse(left_sum, right_sum):
    rev = 0
    temp = right_sum
    while temp != 0:
        rev = rev * 10 + temp % 10
        temp //= 10
    if rev == left_sum:
        return True
    return False

# 38 
def is_composite(n):
    if n <= 1 or n <= 3 or n % 2 == 0 or n % 3 == 0:
        return True
    for i in range(5, int(n**0.5) + 6):
        if n % i == 0 or n % (i + 2) == 0:
            return True
    return False

# 39 
def min_deletion(s):
    n = len(s)
    first_idx = -1
    last_idx = -1
    for i in range(n):
        if s[i] == '1':
            first_idx = i
            break
    for i in range(n-1, -1):
        if s[i] == '0':
            last_idx = i
            break
    if first_idx == -1 or last_idx == -1:
        return 0
    count1 = 0
    count0 = 0
    for i in range(0, last_idx):
        if s[i] == '1':
            count1 += 1
    for i in range(first_idx + 1, n):
        if s[i] == '1':
            count0 += 1
    return min(count0, count1)

# 40 
def minSteps(s, n):
    smaller = 0
    cost = 0
    f = [26] * n
    for i in range(n):
        currEle = s[i] - 'a'
        smaller = 0
        for j in range(currEle + 1):
            if f[j] != 0:
                smaller += f[j]
        if smaller == 0:
            cost += i + 1
        else:
            cost += i - smaller + 1
        f[s[i] - 'a'] += 1
    return cost

# 41 
def number_of_ways(n):
    count = 0
    for a in range(1, n):
        for b in range(0, n):
            for c in range(n - (a + b)):
                if a + b > c and a + c > b and b + c > a:
                    count += 1
    return count

# 42 
def slope_of_num(num, n):
    slope = 0
    for i in range(1, n-1):
        if num[i] > num[i-1] and num[i] > num[i+1]:
            slope += 1
        elif num[i] < num[i-1] and num[i] < num[i+1]:
            slope += 1
    return slope

# 43 
def middle_of_three(a, b, c):
    x = a - b
    y = b - c
    z = a - c

# 44 
def count_max_set_bits(left, right):
    while (left | (left + 1)) <= right:
        left |= 1
    return left

# 45 
def findS(s):
    l, r = 1, s // 2 + 1
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
    eSum = max * (max + 1) / 2 - min * (min + 1) / 2
    return sum == eSum

# 47 
def minimum_possible_product(k):
    res = 1
    r = (1 << k) - 1
    for i in range(k):
        res *= r - 1
    res *= r
    return res

# 48 
def find_in_grid(i, j):
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
    while (x2 > x1 and y2 > y1):
        if (x2 > y2):
            x2 %= y2
        else:
            y2 %= x2
    if (x2 == x1):
        return (y2 - y1) >= 0 and (y2 - y1) % x1 == 0
    else if (y2 == y1):
        return (x2 - x1) >= 0 and (x2 - x1) % y1 == 0
    else:
        return False

# 51 
def find_max_soln(n, x, y):
    ans = float('-inf')
    for k in range(n+1):
        if k % x == y:
            ans = max(ans, k)
    return ans if ans >= 0 and ans <= n else -1

# 52 
def number_of_pairs(n):
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
        return ans + (n - 1) * k_visible_from_left(n - 1, k - 1)

# 55 
def find(n, sum):
    if sum > 6 * n or sum < n:
        return 0
    elif n == 1:
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
        val /= i + 1
    return val

# 57 
def get_mask(val):
    mask = 0
    if val == 0:
        return 1
    while val > 0:
        d = val % 10
        mask |= 1 << d
        val = val / 10
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
    else:
        if last_bit == 0:
            no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits, 1)
            no_of_ways += ways_to_k_adjacent_set_bits(n, k, current_index + 1, adjacent_set_bits, 0)
    return no_of_ways

# 59 
def check_func(i, j, st):
    if (st[i] == '(' and st[j] == ') or (st[i] == '?' and st[j] == '?'):
        return 1
    elif (st[i] == '[' and st[j] == ']'):
        return 1
    elif (st[i] == '?' and st[j] == '?'):
        return 1
    elif (st[i] == '{' and st[j] == '}'):
        return 1
    elif (st[i] == '{' and st[j] == '?'):
        return 1
    return 0

# 60 
def findGolomb(n):
    if n == 1:
        return 1
    return 1 + findGolomb(n - findGolomb(findGolomb(n - 1)))

# 61 
def allOnes(s, n):
    count = 0
    for i in range(len(s)):
        if s[i] == '1':
            count += 1
    return count == n

# 62 
def pad(n):
    p_prev_prev = 1
    p_prev = 1
    p_curr = 1
    p_next = 1
    for i in range(3, n + 1):
        p_next = p_prev_prev + p_prev
        p_prev_prev = p_prev
        p_prev = p_curr
        p_curr = p_next
    return p_next

# 63 
def odd_length_palindrome(k):
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
    n = len(s)
    if s[0] == '?':
        s[0] = 'a'
    if s[0] == s[1]:
        s[0] = 'a'
    if s[0] == s[n-1]:
        s[0] = 'a'
    for i in range(1, n-1):
        if s[i] == '?':
            s[i] = 'a'
        if s[i] == s[i-1]:
            s[i] = 'a'
        if s[i] == s[i+1]:
            s[i] = 'a'
    if s[n-1] == '?':
        s[n-1] = 'a'
    if s[n-1] == s[n-2]:
        s[n-1] = 'a'
    return ''.join(s)

# 65 
def total_hamming_distance(n):
    i = 1
    sum = 0
    while n / i > 0:
        sum += n / i
        i *= 2
    return sum

# Testing
print(total_hamming_distance(10))
# Expected output: 10

# 66 
def check_bitonic(s):
    i = 1
    for _ in range(len(s)):
        if s[i] > s[i-1]:
            continue
        elif s[i] <= s[i-1]:
            break
        if i == len(s) - 1:
            return 1
        j = i + 1
        for _ in range(len(s)):
            if s[j] < s[j-1]:
                continue
            elif s[j] >= s[j-1]:
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
    mod = 10**9 + 7
    hash_val = 0
    mul = 1
    for ch in s:
        hash_val = (hash_val + (ord(ch) - ord('a') + 1) * mul % mod
        mul = mul * p % mod
    return int(hash_val)

# 71 
def count_of_substring_with_only_ones(s):
    res = 0
    count = 0
    for i in range(len(s)):
        if s[i] == '1':
            count += 1
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
        sum += ord(s[i]) - ord('a') + 1
    if sum % 3 != 0:
        return False
    last_digit = ord(s[-1]) - ord('a') + 1
    if last_digit % 2 != 0:
        return False
    return True

# 74 
def is_redundant_braces(s):
    a, b = 0, 0
    for i in range(len(s)):
        if s[i] == '(' and s[i+2] == ')':
            a += 1
        elif s[i] == '*' or s[i] == '+' or s[i] == '-' or s[i] == '/':
            b += 1
        if b > a:
            return True
    return False

# 75 


# 76 
def prefix_occurrences(s):
    c = s[0]
    countC = 0
    for i in range(len(s)):
        if s[i] == c:
            countC += 1
    return countC

# Testing
print(prefix_occurrences("aaa")) # Should return 3
print(prefix_occurrences("zzz")) # Should return 0
print(prefix_occurrences("abc")) # Should return 1
print(prefix_occurrences(""))   # Should return 0

# 77 
def is_valid(s, length):
    for i in range(1, length):
        if s[i] == s[i-1]:
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
    for i in range(k):
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
        if s[i] + s[i+1] in s:
            result += 1
            while i < n - 1 and s[i] + s[i+1] in s:
                i += 1
        return result

# 80 
def find(s1, s2):
    len1 = len(s1)
    len2 = len(s2)
    if len1 != len2:
        return False
    d = [0]*len2
    d[0] = s2[0] - s1[0]
    for i in range(1, len1):
        if s1[i] > s2[i]:
            return False
        d[i] = s2[i] - s1[i]
    for i in range(0, len1-1):
        if d[i] < d[i+1]:
            return False
    return True

# 81 
def is_in_given_base(s, base):
    if base > 16:
        return False
    elif base <= 10:
        for i in range(len(s)):
            if not (s[i] >= '0' and s[i] < '0' + base):
                return False
    else:
        for i in range(len(s)):
            if not (s[i] >= '0' and s[i] < '0' + base) or (s[i] >= 'A' and s[i] < 'A' + base - 10):
                return False
    return True

# 82 
def count_non_empty_substr(s):
    n = len(s)
    return n * (n + 1) // 2

# Testing the function
print(count_non_empty_substr("Hello")) # Should return 10
print(count_non_empty_substr(""))    # Should return 0
print(count_non_empty_substr("abcdef")) # Should return 15
print(count_non_empty_substr("aabbcc")) # Should return 20
print(count_non_empty_substr("aaaaa"))   # Should return 25
print(count_non_empty_substr("abcabc"))  # Should return 30
print(count_non_empty_substr("123456"))  # Should return 30
print(count_non_empty_substr(""))       # Should return 0

# 83 
def even_decimal_value(s, n):
    result = 0
    for i in range(n):
        for j in range(i, n):
            decimal_value = 0
            power_of_2 = 1
            for k in range(i, j):
                decimal_value += (ord(s[k]) - ord('0')) * power_of_2
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
                        if i + j + k == l + m:
                            s = '0'
                            if i != s[0]: s = chr(0)
                            if j != s[1]: s = chr(1)
                            if k != s[2]: s = chr(2)
                            if l != s[3]: s = chr(3)
                            if m != s[4]: s = chr(4)
                            if n != s[5]: s = chr(5)
    return ans

# 85 
def xorZero(s):
    one_count = 0
    zero_count = 0
    n = s.length()
    for i in range(n):
        if s[i] == '1':
            one_count += 1
        else:
            zero_count += 1
    if one_count % 2 == 0:
        return zero_count
    return one_count

# 86 
def even_length(n):
    res = n
    for j in range(len(n)-1, -1):
        res += n[j]
    return res

# 87 
def count_substring_with_equal_ends(s):
    result = 0
    n = len(s)
    for i in range(n):
        for j in range(i, n):
            if s[i] == s[j]:
                result += 1
    return result

# 88 
def normal_slope(a, b, x1, y1):
    g = a / 2
    f = b / 2
    if (g - x1 == 0):
        return -1
    slope = (f - y1) / (g - x1)
    if (slope == 0):
        return -2
    return slope

# 89 
def orthogonality(x1, y1, x2, y2, r1, r2):
    dsquare = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
    if dsquare == r1 * r1 + r2 * r2:
        return True
    else:
        return False

# 90 
def find_area_shaded(a):
    sq_area = a * a
    semi_circle_area = 3.14 * (a * a) / 8
    shaded_area = 4 * semi_circle_area - sq_area
    return shaded_area

# 91 
def factorial(a, b):
    res = 1
    for i in range(1, a + b + 1):
        res *= i
    for i in range(1, a + 1):
        res /= i
    for i in range(1, b + 1):
        res /= i
    return res

# 92 
def factor_tree(n):
    height = 0
    while n > 1:
        flag = False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                n = n / i
                flag = True
                break
        height += 1
        if not flag:
            break
    return height

# 93 
def find_if_possible(n, s, x):
    if s >= x and s % 2 == x % 2 and n >= 3:
        if n >= 1 and s == x:
            c = (s - x) // 2
            a = c
            b = c
            a = a + x
            if a ^ b == x:
                return "Yes"
        elif n == 2 and s == x:
            c = (s - x) // 2
            a = c
            b = c
            a = a + x
            if a ^ b == x:
                return "Yes"
    return "No"

# 94 
def maximum_triplet_xor(a, b, c):
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
def item_type(n):
    count = 0
    day = 1
    while count + day * (day + 1) / 2 < n:
        count += day * (day + 1) / 2
        day += 1
    for type in range(1, 0):
        count += type
        if count >= n:
            return type
    return 0

# 96 
def max_gcd_in_range(l, r):
    ans = 1
    for z in range(l, r+1):
        if (r / z - (l - 1) / z) > 1:
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
        s = str(n)
        d = s[1] - s[0]
        for i in range(2, len(s)):
            if s[i] - s[i-1] != d:
                return False
        return True

# 100 
def getCount(d, n):
    no = n / d
    result = 0
    for p in range(2, int(no**0.5) + 1):
        if no % p == 0:
            while no % p == 0:
                no /= p
            result -= result / p
        if no > 1:
            result -= result / no
    return result

# 101 
def is_even_parity(x):
    parity = 0
    while x != 0:
        if x % 2 == 1:
            parity += 1
        x >>= 1
    if parity % 2 == 0:
        return True
    else:
        return False

# 102 
def isPerfect(n):
    sum = 1
    for i in range(2, n+1):
        if n % i == 0:
            if i * i != n:
                sum += i + n // i
    if sum == n and n != 1:
        return n
    return 0

# 103 
def logAToBaseB(a, b):
    return a > b - 1 ? 1 + logAToBaseB(a / b) : 0

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
def min_int(s):
    s1 = list(s)
    for i in range(len(s)):
        if s1[i] >= '5':
            s1[i] = chr(ord(s1[i]) - 9)
        if s1[0] == '0':
            s1[0] = '9'
    return ''.join(s1)

# 106 
def count_triplets(a, b, c):
    ans = 0
    for i in range(1, a+1):
        for j in range(1, b+1):
            for k in range(1, c+1):
                if i * k > j * k:
                    ans += 1
    return ans

# 107 
def topsy_turvy(s):
    for i in range(len(s)):
        if s[i] in ['2', '4', '5', '6', '7', '9']:
            return False
    return True

# 108 
def sum_of_last_digit(n, m):
    sum = 0
    k = n // m
    arr = [10] * k
    for i in range(10):
        arr[i] = m * (i + 1) % 10
        sum += arr[i]
    rem = k % 10
    ans = rem // 10 * sum
    for i in range(rem):
        ans += arr[i]
    return ans

# 109 
def total_pay(total_items, price_of_one_item, n, m):
    free_items = 0
    actual = 0
    free_items = total_items / (n + m)
    actual = total_items - free_items
    amount = actual * price_of_one_item
    return amount

# 110 
def min_operations(x, y, p, q):
    if y % x != 0:
        return -1
    d = y / x
    a = 0
    while d % p == 0:
        d /= p
        a += 1
    b = 0
    while d % q == 0:
        d /= q
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
def find_third_digit(n):
    if n < 3:
        return 0
    else:
        return (n & 1) != 0 and 1 or 6

# 113 
def is_odd_length(num):
    count = 0
    while num > 0:
        num /= 10
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
def bytes_to_kilobytes(kilobytes):
    b = kilobytes * 1024
    return b

# 116 
def octahedral_num(n):
    return n * (2 * n * n + 1) / 3

# 117 
def check_equal(s):
    for i in range(len(s)):
        if s[i] != '1' and s[i] != '0' and s[i] != '8':
            return "No"
    start = 0
    end = len(s) - 1
    while start < end:
        if s[start] != s[end]:
            start += 1
            end -= 1
    return "Yes"

# 118 
def isUndulating(n):
    if len(n) <= 2:
        return False
    for i in range(2, len(n)):
        if n[i-2] != n[i]:
            return False
    return True

# 119 
def first_digit(n):
    while n >= 10:
        n /= 10
    return n

# Testing
print(first_digit(123)) # Should print 123
print(first_digit(98765)) # Should print 98765
print(first_digit(123456)) # Should print 123456
print(first_digit(987654321)) # Should print 987654321
print(first_digit(0)) # Should print 0

# 120 
def count_digit(n):
    if n == 0:
        return 0
    else:
        return 1 + count_digit(n // 10)

# 121 
def is_divisible_by_5(s):
    n = s.length()
    return s[n-1] == '0' or s[n-1] == '5'

# 122 
def calc(a, m):
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
        if x1 < 0:
            x1 += m0
    return x1

# 123 
def only_first_and_last_are_set(n):
    if n == 1:
        return True
    elif n == 2:
        return False
    else:
        return (n - 1) & (n - 2) == 0

# 124 
def divide(dividend, divisor):
    if (dividend < 0) ^ (divisor < 0):
        sign = -1 if (dividend < 0) else 1
        dividend = abs(dividend)
        divisor = abs(divisor)
        quotient = 0
        temp = 0
        for i in range(31, 0, -1):
            if (temp + (divisor << i) <= dividend):
                temp += (divisor << i)
                quotient |= 1 << i
        if sign == -1:
            quotient = -quotient
        return quotient

# 125 
def findProfession(level, pos):
    if level == 1:
        return 'e'
    elif findProfession(level - 1, (pos + 1) / 2) == 'd':
        return pos % 2 != 0 ? 'd' : 'e'
    return pos % 2 != 0 ? 'e' : 'd'

# 126 
def has_close_elements(numbers, threshold):
    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            distance = abs(numbers[i] - numbers[j])
            if distance < threshold:
                return True
    return False

# 127 
def truncate_number(number):
    return number % 1.0

# 128 
def below_zero(operations):
    balance = 0
    for op in operations:
        balance += op
        if balance < 0:
            return True
    return False

# 129 
def mean_absolute_deviation(numbers):
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
    for i in range(len(numbers)-1):
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
        result.append(s[0:i])
    return result

# 133 
def parse_music(music_string):
    result = []
    current = ""
    for i in range(len(music_string)):
        if i == len(music_string) or music_string[i] == ' ':
            if current == "o":
                result.append(4)
            elif current == "o|":
                result.append(2)
            elif current == ".|":
                result.append(1)
            else:
                current += music_string[i]
    return result

# 134 
def str_len(s):
    return len(s)

# 135 
def factorize(n):
    factors = []
    for i in range(2, n + 1):
        if n % i == 0:
            n //= i
            factors.append(i)
            i -= 1
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
    evens = []
    for i in range(0, len(l), 2):
        evens.append(l[i])
    evens.sort()
    result = []
    for i in range(0, len(l), 2):
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
    return pow(n, 2)

# 141 
def incr_list(l):
    result = []
    for i in l:
        result.append(i + 1)
    return result

# 142 
def pairs_sum_to_zero(l):
    for i in range(len(l)):
        for j in range(i+1, len(l)):
            if l[i] + l[j] == 0:
                return True
    return False

# 143 
def change_base(x, b):
    ret = ""
    while x > 0:
        ret = str(x % b) + ret
        x //= b
    return ret[::-1]  # Reverses the string and returns

# 144 
def median(l):
    l.sort()
    if len(l) % 2 == 1:
        return l[len(l) // 2]
    return (l[len(l) // 2 - 1] + l[len(l) // 2]) / 2.0

# 145 
def decode_shift(s):
    sb = ""
    for ch in s:
        w = ord(ch) - ord('a') + 26
        sb += chr(w % 26 + ord('a'))
    return sb

# 146 
def below_threshold(l, t):
    for n in l:
        if n >= t:
            return False
    return True

# 147 
def correctBracketing(brackets, depth=0):
    for b in brackets:
        if b == '<':
            depth += 1
        elif b == '>':
            depth -= 1
        if depth < 0:
            return False
    return depth == 0

# 148 
def is_monotonic(lst):
    incr = decr = 0
    for i in range(1, len(lst)):
        if lst[i] > lst[i - 1]:
            incr += 1
        if lst[i] < lst[i - 1]:
            decr += 1
    return incr + decr != 2

# 149 
def derivative(xs):
    result = []
    for i in range(1, len(xs)):
        result.append(i * xs[i])
    return result

# 150 
def vowels_count(s):
    vowels = "aeiouAEIOU"
    count = 0
    for ch in s:
        if ch in vowels:
            count += 1
    if s[-1] == 'y' or s[-1] == 'Y':
        count += 1
    return count

# 151 
def digit_sum(s):
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
        else:
            if not flag and num1.length() > 0:
                flag = True
    return n - int(num1) - int(num2)

# 153 
def pluck(arr):
    result = []
    for i in range(len(arr)):
        if arr[i] % 2 == 0:
            if not result:
                result.append(arr[i])
            else:
                result[0] = arr[i]
                result[1] = i
    return result

# 154 
from typing import List
import collections

def strange_sort(lst: List[int]) -> List[int]:
    res = collections.deque()
    lst = collections.deque(sorted(lst))
    l = 0
    r = len(lst) - 1
    while l < r:
        res.append(lst[l])
        l += 1
        res.append(lst[r])
        r -= 1
        if l == r:
            res.append(lst[l])
    return list(res)

# 155 
def triangle_area(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a:
        return -1
    s = (a + b + c) / 2
    return math.sqrt(s * (s - a) * (s - b) * (s - c))

# 156 
def will_it_fly(q, w):
    sum = 0
    for i in range(len(q)):
        if q[i] != w[i]:
            return False
        sum += q[i]
    return sum <= w

# 157 
import math

def is_cube(a):
    a = abs(a)
    i = round(math.pow(a, 1.0/3))
    return math.pow(i, 3) == a

# 158 
def hex_key(num):
    key = "2357BD"
    total = 0
    for c in num:
        if c in key:
            total += 1
    return total

# 159 
def decimal_to_binary(dec):
    ans = ""
    if dec != 0:
        while dec > 0:
            ans = "0" + str(dec % 2) + ans
        dec /= 2
    else:
        ans = "0"
    return "db" + ans + "db"

# Testing
print(decimal_to_binary(10))
print(decimal_to_binary(0))
print(decimal_to_binary(-10))

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
    elif n == 1:
        return 1
    else:
        return int(18 * pow(10, n - 2))

# 162 
def add(lst):
    sum = 0
    for i in range(1, len(lst), 2):
        if lst[i] % 2 == 0:
            sum += lst[i]
    return sum

# 163 
def get_row(lst, x):
    coords = []
    for i in range(len(lst)):
        for j in range(len(lst[i]) - 1):
            if lst[i][j] == x:
                coords.append([i, j])
    return coords

# 164 
def next_smallest(lst):
    sorted_lst = sorted(lst)
    for i in range(1, len(sorted_lst)):
        if sorted_lst[i] != sorted_lst[i - 1]:
            return sorted_lst[i]
    return -1

# 165 
def any_int(a, b, c):
    if round(a) != a or round(b) != b or round(c) != c:
        return False
    return a + b == c or a + c == b or b + c == a

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
def make_apile(n):
    result = []
    for i in range(n):
        result.append(n + 2 * i)
    return result

# 169 
from typing import List

def word_strings(s: str) -> List[str]:
    words = []
    current = ""
    for i in range(len(s)):
        if i == len(s) or s[i] == ' ' or s[i] == ',' :
            if len(current) > 0:
                words.append(current.to_string())
                current.setlength(0)
        else:
            current.append(s[i])
    return words

# 170 
def rounded_avg(n, m):
    if n > m:
        return -1
    num = (m + n) // 2
    ret = ''
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
            if ord(c) % 2 == 0:
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
        neg = 1 if n < 0 else -1
        n = abs(n)
        digits = list(str(n))
        for c in digits:
            digits.add(c - '0')
        digits.set(0)
        digits.get(0)
        sum = 0
        for d in digits:
            sum += d
        if sum > 0:
            num += 1
    return num

# 173 
def move_one_ball(arr):
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
        result = ""
        for c in original_str:
            if c == 'i':
                result += str(sum)
            else:
                result += c
        results.append(result)
    return results

# 176 
import sys

def minSubArraySum(nums):
    min_sum = sys.maxsize
    sum = 0
    for num in nums:
        sum += num
        if min_sum > sum:
            min_sum = sum
        if sum > 0:
            sum = 0
    return min_sum

# 177 
def max_fill(grid, capacity):
    res = 0
    for well in grid:
        sum = 0
        for n in well:
            sum += n
        if sum > 0:
            res += (sum - 1) / capacity + 1
    return res

# 178 
def select_words(s, n):
    vowels = "aeiouAEIOU"
    result = []
    consonant_num = 0
    for i in range(len(s)):
        if i == len(s) or s[i] == ' ':
            if consonant_num == n:
                result.append(s)
                s = s[:i] + s[i+1:]
                consonant_num = 0
        else:
            s[i]
            if s[i] in vowels:
                consonant_num += 1
            else:
                consonant_num = 0
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
def getOddCollatz(n):
    oddCollatz = []
    while n != 1:
        if n % 2 == 1:
            oddCollatz.append(n)
            n = n * 3 + 1
        else:
            n = n / 2
    oddCollatz.append(1)
    oddCollatz.sort()
    return oddCollatz

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
    inter1 = max(0, interval1.get(0))
    inter2 = min(1, interval2.get(1))
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
        elif i < 0:
            prods = - prods
    return sum * prods

# 185 
def minPath(grid, k):
    n = len(grid)
    minNum = 0
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
                minNum = min(tmp)
    return minNum

# 186 
def digits(n):
    prod = 0
    for digit in str(n):
        if int(digit) % 2 == 1:
            if prod == 0:
                prod = 1
            prod *= int(digit) - '0'
    return prod

# 187 
def is_nested(s):
    count = 0
    max_count = 0
    for ch in s:
        if ch == '[':
            count += 1
        elif ch == ']':
            count -= 1
        if count < 0:
            count = 0
        if count > max_count:
            max_count = count
        if count <= max_count - 2:
            return True
    return False

# 188 
import math

def sum_squares(lst):
    sum = 0
    for i in lst:
        sum += math.ceil(i) * math.ceil(i)
    return sum

# 189 
def can_arrange(arr):
    index = -1
    for i in range(len(arr)):
        if arr[i] <= i:
            index = i
    return index

# 190 
def largest_smallest_numbers(lst):
    max_neg = None
    min_pos = None
    for n in lst:
        if n < 0 and (max_neg is None or n > max_neg):
            max_neg = n
        elif n > 0 and (min_pos is None or n < min_pos):
            min_pos = n
    return [max_neg, min_pos]

# 191 
def fix_spaces(text):
    res = ''
    space_len = 0
    for i in range(len(text)):
        if i == len(text) or text[i] != ' ':
            if space_len == 1:
                res += '_'
            elif space_len == 2:
                res += '__'
            elif space_len > 2:
                res += '-'
            space_len = 0
            if i != len(text):
                res += text[i]
        return res.replace('\s+', '_')

# 192 
def filename_check(file_name, digit_num=0, dot_num=0):
    if len(file_name) < 5 or not file_name[0].isalpha() or not file_name[-4:].endswith('.txt') and not file_name[-4:].endswith('.exe') and not file_name[-4:].endswith('.dll') :
        return "No"
    suffix = file_name[len(file_name)-4:]
    if not suffix.endswith('.txt') and not suffix.endswith('.exe') and not suffix.endswith('.dll') :
        return "No"
    for c in file_name:
        if c.isdigit():
            digit_num += 1
        elif c == '.':
            dot_num += 1
    if digit_num > 3 or dot_num != 1:
        return "No"
    return "Yes"

# 193 


# 194 
def words_in_sentence(sentence):
    result = ""
    current = ""
    for i in range(len(sentence)):
        if i == len(sentence) or sentence[i] == ' ':
            is_prime = True
            l = current.__len__()
            if l < 2:
                is_prime = False
            for j in range(2, l):
                if l % j == 0:
                    is_prime = False
                    break
            if is_prime:
                result += current + ' '
            current += sentence[i]
        if len(result) > 0:
            result = result[:-1]
    return result

# 195 
def simplify(x, n):
    a, b, c, d = 0, 0, 0, 0
    for i in range(len(x)):
        if x[i] == '/':
            a = int(x[0:i])
            b = int(x[i+1:])
        if n[i] == '/':
            c = int(n[0:i])
            d = int(n[i+1:])
        if a * c % (b * d) == 0:
            return True
    return False

# 196 
def special_filter(nums):
    count = 0
    for num in nums:
        if num > 10:
            w = str(num)
            if w[0] % 2 == 1 and w[len(w)-1] % 2 == 1:
                count += 1
    return count

# 197 
def get_max_triples(n):
    arr = []
    for i in range(1, n+1):
        arr.append(i*i - i + 1)
    count = 0
    for i in range(n):
        for j in range(i+1, n):
            for k in range(j+1, n):
                if (arr[i] + arr[j] + arr[k]) % 3 == 0:
                    count += 1
    return count

# 198 
def double_the_difference(lst):
    sum = 0
    for d in lst:
        num = round(d)
        if num > 0 and num % 2 == 1:
            sum += num * num
    return sum

# 199 
import math

def compare(game, guess):
    result = []
    for i in range(len(game)):
        result.append(math.fabs(game[i] - guess[i]))
    return result

# 200 
def strongest_extension(className, extensions):
    strongest = ""
    max = float('-inf')
    for extension in extensions:
        strength = 0
        for chr in extension:
            if chr.isupper():
                strength += 1
            elif chr.islower():
                strength -= 1
        if strength > max:
            max = strength
            strongest = extension
    return className + '.' + strongest

# 201 
def int_to_mini(number):
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
    if need > remaining:
        return remaining
    else:
        return eat(number + need, remaining - need)

# Testing
print(eat(1, 2, 3))

# 203 
import math

def do_algebra(ops, operands):
    nums = []
    current_ops = []
    i = 0
    while i >= 0:
        if current_ops[i] == "**":
            nums.append(math.pow(nums[i], nums[i+1]))
            nums.remove(i+1)
            current_ops.remove(i)
        else:
            i += 1
    return nums[0]

# 204 
import random

def generate_integers(a, b):
    lower = max(2, min(a, b))
    upper = min(8, max(a, b))
    result = []
    for i in range(lower, upper+2, 2):
        result.append(i)
    return result

# 205 
def isStepNum(n):
    prev_digit = -1
    while n > 0:
        curr_digit = n % 10
        if prev_digit != -1:
            if abs(curr_digit - prev_digit) != 1:
                return False
        n //= 10
        prev_digit = curr_digit
    return True

# 206 
def numOfWays(n, k):
    p = 1
    if k % 2 != 0:
        p = -1
    return int((pow(n - 1, k) + p * (n - 1)) / n)

# 207 
import math

def find_divisors(n):
    v = []
    for i in range(1, math.isqrt(n) + 1):
        if n % i == 0:
            if n // i == i:
                v.append(i)
            else:
                v.append(i)
                v.append(n // i)
    return v

# 208 
def egg_drop(n, k):
    if k == 1 or k == 0:
        return k
    if n == 1:
        return k
    min = float('inf')
    res = 0
    for x in range(1, k+1):
        res = max(egg_drop(n - 1, x - 1), egg_drop(n, k - x))
        if res < min:
            min = res
    return min + 1

# 209 
def is_power_of_two(n):
    if n == 0:
        return False
    return math.ceil(math.log(n) / math.log(2)) == math.floor(math.log(n) / math.log(2))

# 210 
def shortest_palindrome(s):
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
        v.append(ans1)
        v.append(ans2)
    ans = v[0]
    for i in range(len(v)):
        if v.get(i) != "":
            if ans[0] >= v.get(i):
                ans = v.get(i)
    return ans

# 211 
import sys

def minimumAdjacentDifference(a, n, k):
    min_diff = sys.maxsize
    for i in range(k):
        max_diff = -sys.maxsize
        for j in range(i, n - k):
            for p in range(i, i + j + 1):
                max_diff = max(max_diff, a[p + 1] - a[p])
        min_diff = min(min_diff, max_diff)
    return min_diff

# 212 
def calc(arr, mid):
    chocolate = 0
    for i in arr:
        if i >= mid:
            chocolate += i - mid
    return chocolate

# 213 
def check(v, a, m):
    ans = 0
    b = [0]*3
    for i in range(a.size()):
        tec = 0
        if a.get(i) + tec < v:
            mov = v - a.get(i)
            ans += mov
            tec += mov
            b[i+2] = tec
    return ans <= m

# 214 
def largest_num(arr):
    res = 0
    arr.sort()
    l = 0
    r = len(arr) - 1
    while l < r:
        sum = arr[l] + arr[r]
        if sum == 0:
            res = max(res, max(arr[l], arr[r]))
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
def minDigits(n, k):
    digitsNum = int(n**(k+1)-1)
    tempSum = 0
    temp = digitsNum
    result = 0
    x = 0
    while(temp != 0):
        v = n // (10 ** (temp - 1))
        tempSum += v % 10
        if(tempSum <= k):
            x = 0
        else:
            while(temp > 0):
                v = n // (10 ** (temp - 1))
                tempSum += v % 10
                if(tempSum >= k):
                    v /= 10
                    v += 1
                temp -= 1
            x = result
            return x if x >= 0 else -1

# 218 
def check_for_perfect_square(arr, i, j):
    mid, sum = 0, 0
    for m in range(i, j+1):
        sum += arr[m]
    low, high = 0, sum // 2
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
            if mat[i][j] != s[i+j]:
                count += 1
    return count

# 220 
from collections import defaultdict

def constructTree(n, edges):
    adjl = defaultdict(lambda: set())
    for i in range(n):
        adjl[i] = set()
    for e in edges:
        u, v = e[0], e[1]
        adjl[u].add(v)
        adjl[v].add(u)
    return adjl

# 221 
def find_sum_of_values(v, parent, values_children):
    cur_node = v
    sum = 0
    while cur_node != -1:
        sum += values_children.get(cur_node)
        cur_node = parent.get(cur_node)
    return sum

# 222 
def get_distinct(d, count):
    num = 0
    count = int(pow(10, count - 1))
    while count > 0:
        num += count * d
        count /= 10
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
    cntZero = [[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(n-1, 0, -1):
            if mat[i][j] == 0 and j != n - i - 1:
                cntZero[i][j] = cntZero[i][j+1] + 1
    cntSwaps = 0
    for i in range(n):
        if cntZero[i][i] < (n - i - 1):
            first = i
            while first < n and cntZero[first][first] < (n - i - 1):
                first += 1
            if first == n:
                return -1
            while first > i:
                cntSwaps += 1
            cntZero[i][first-1] = cntZero[i][first] + 1
            first --
    return cntSwaps

# 225 
def solve(values, salary, mod):
    ret = 1
    amt = 0
    values.sort()
    salary.sort()
    while salary:
        while values and values[-1] >= salary[-1]:
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
    result = [0]*n
    vec.sort()
    i, j = 0, n - 1
    k = 0
    while i <= j and k <= n - 2:
        if str(op.get(k)) == '<':
            result[k] = vec.get(i + 1)
            i += 1
        else:
            result[k] = vec.get(j)
            j -= 1
        k += 1
    result[n - 1] = vec.get(i)
    return result

# 227 
def count_points(n, m, a, b, x, y):
    a.sort()
    b.sort()
    j = 0
    count = 0
    for i in range(n):
        while j < m:
            if a[i] + y < b[j] and b[j] >= a[i] - x and b[j] <= a[i] + y:
                count += 1
                j += 1
            else:
                j += 1
    return count

# 228 
def are_same(a, b):
    return sorted(a) == sorted(b)

# 229 
def count_number_of_strings(s):
    n = s.length() - 1
    count = int(math.pow(2, n))
    return count

# 230 
def prime_power(x):
    prime_pow = []
    for i in range(2, x + 1):
        if x % i == 0:
            p = 1
            while x % i == 0:
                x /= i
                p *= i
            if x > 1:
                prime_pow.append(x)
    return prime_pow

# 231 
import math

def isPerfect(n):
    n = math.sqrt(n)
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
    for i in range(l, r + 1):
        sum += arr[i]
    return sum

# 233 
import math

def results(n, k):
    return round(math.pow(n, 1.0 / math.pow(2.0, k)))

# 234 
import math

def factors(n):
    v = []
    v.add(1)
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            v.add(i)
            if n / i != i:
                v.add(n / i)
    return v

# 235 
import math

def smallest_num(n):
    x = math.pow(10, (n - 1) / 2.0)
    return math.ceil(x)

# 236 
def smallest(s):
    a = [0]*26
    for i in range(len(s)):
        a[i] = ord(s[i]) - ord('a')
    b = []
    for i in range(len(a)):
        if a[i] % 2 != 0:
            b.append(a[i])
    b.sort()
    if len(b) > 1:
        return b[0]*10 + b[1]
    return -1

# 237 
import math

class Diagonals:
    def __init__(self, a, b, c, d):
        self.ans = []
        self.ans.append(math.sqrt(a * c + b * d) * math.sqrt(a * d + b * c))
        self.ans.append(math.sqrt(a * c + b * d) * math.sqrt(a * d + b * c))
        return self.ans

# 238 
import math

def find_number_of_digits(n, base):
    dig = math.floor(math.log(n) / math.log(base)) + 1
    return dig

# 239 
import math

def nGon(n):
    proAngleVar = math.pi * (180.0 / n) / 180 if n % 4 == 0 else math.pi * (180.0 / (2 * n)) / 180
    negX = 1e+99
    posX = -1e+99
    negY = 1e+99
    posY = -1e+99
    for j in range(int(n)):
        px = math.cos(2 * math.pi * j / n + proAngleVar)
        py = math.sin(2 * math.pi * j / n + proAngleVar)
        negX = min(negX, px)
        posX = max(posX, px)
        negY = min(negY, py)
        posY = max(posY, py)
    opt2 = max(posX - negX, posY - negY)
    return opt2 / math.sin(math.pi / n) / 2

# 240 
import math

def findMaxK(n):
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
def find_prob(l, r):
    count_of_ps = int(r**0.5) - int(l**0.5) + 1
    total = r - l + 1
    prob = count_of_ps / total
    return prob

# 243 
def previous_fibonacci(n):
    a = n / ( (1 + (5**0.5)) / 2.0)
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
    k = sorted(counts)
    if len(k) == 1 or (k[0] == 1 and k[-1] == k[-1] - 1) or (k[0] == 1 and k[1] == k[-1] - 1):
        ans = index + 1
    return ans

# 247 
def max_edges(n):
    edges = int(n * n / 4)
    return edges

# 248 
def findK(n, k):
    a = []
    for i in range(1, n+1):
        if i % 2 == 1:
            a.append(i)
    for i in range(1, n+1):
        if i % 2 == 0:
            a.append(i)
    return a[k-1]

# 249 
def isKeith(x, temp):
    terms = []
    n = 0
    while temp > 0:
        terms.append(temp % 10)
        temp = temp // 10
        n += 1
    terms.reverse()
    next_term = 0
    i = n
    while next_term < x:
        next_term = 0
        for j in range(1, n + 1):
            next_term += terms.get(i - j)
        terms.append(next_term)
        i += 1
    return next_term == x

# 250 
def factors(n, k):
    v = []
    while n % 2 == 0:
        v.append(2)
        n /= 2
    if len(v) >= k:
        return True
    for i in range(3, int(n**0.5) + 1, 2):
        while n % i == 0:
            n /= i
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
    current_paren = []
    current_depth = 0
    for c in paren_string:
        if c == '(':
            current_depth += 1
            current_paren.append(c)
        elif c == ')':
            current_depth -= 1
            current_paren.append(c)
            if current_depth == 0:
                all_parens.append(''.join(current_paren))
                current_paren.clear()
        return all_parens

# 252 
def parse_nested_parens(parens_string):
    all_levels = []
    level = 0
    max_level = 0
    for i in range(len(parens_string)):
        chr = parens_string[i]
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
class RollingMax:
    def __init__(self, numbers):
        self.numbers = numbers
        self.result = []
        self.running_max = 0

    def add(self, n):
        if n > self.running_max:
            self.running_max = n
        self.result.append(self.running_max)
        return self.result

# 255 
def makePalindrome(s):
    if s == "":
        return ""
    for i in range(len(s)):
        rStr = s[i:]
        if rStr == rStr[::-1]:
            nStr = s[0:i]
            n2Str = nStr[::-1]
            return s + n2Str
    return s[0:len(s)-1] + makePalindrome(s[::-1])

# 256 
def string_string_xor(a, b):
    result = ''
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
    return next(s for s in strings if len(s) == max_len)

# 258 
def string_sequence(n):
    s = ''
    for i in range(n):
        s += str(i) + ' ' + str(n)
    return s

# 259 
def count_distinct_characters(s):
    distinct = set()
    for c in s.lower():
        distinct.add(c)
    return len(distinct)

# 260 
def how_many_times(s, sub):
    times = 0
    for i in range(len(s)):
        if s.startswith(sub):
            times += 1
    return times

# 261 
from collections import defaultdict

# Create a dictionary to map string numbers to int
to_num = defaultdict(lambda: 0, "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9)

# Create a list to store ints
nums = []

# Iterate over the numbers
for i in range(len(numbers)):
    if i == len(numbers) or numbers[i] == ' ':
        if to_num[current.to_string()] not in to_num:
            nums.append(to_num[current.to_string()])
            current.setlength(0)
    else:
        current.append(numbers[i])

# Sort the list of ints
nums.sort()

# Create a StringBuilder for the result
result = ""

# Iterate over the sorted ints
for i in range(len(nums)):
    if i != len(nums) - 1:
        result += " "
    result += str(nums[i])

# Return the result as a string
print(result)

# 262 
from typing import List
import math

def find_closest_elements(numbers: List[float]) -> List[float]:
    closest_pair = [0, 1]
    distance = math.fabs(numbers[0] - numbers[1])

    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            temp_distance = math.fabs(numbers[i] - numbers[j])
            if temp_distance < distance:
                closest_pair = [i, j]
                distance = temp_distance
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
    for i in range(len(strings)):
        if strings[i].startswith(prefix):
            result.append(strings[i])
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
                driv += xs[i] * pow(ans, i-1) * i
            ans -= value / driv
            value = 0
    return ans

# 269 
def sort_third(l):
    thirds = []
    for i in range(0, len(l), 3):
        thirds.append(l[i])
    thirds.sort()
    result = []
    for i in range(0, len(l), 3):
        if i % 3 == 0:
            result.append(thirds[i // 3])
        else:
            result.append(l[i])
    return sorted(result)

# 270 
from collections import Counter

def unique(l):
    result = list(Counter(l).elements())
    result.sort()
    return result

# 271 
def max_element(l):
    return max(l)

# 272 
def triples_sum_to_zero(l):
    for i in range(len(l)):
        for j in range(i+1, len(l)):
            for k in range(j+1, len(l)):
                if l[i] + l[j] + l[k] == 0:
                    return True
    return False

# 273 
def fib(n):
    results = [0, 0, 2, 0]
    for i in range(4, n+1):
        results.append(results[i-4] + results[i-3] + results[i-2] + results[i-1])
    return results[n]

# 274 
def is_palindrome(text):
    return text == text[::-1]

# 275 
def remove_vowels(text):
    result = ""
    vowels = "aeiou"
    for ch in text:
        if ch.lower() not in vowels:
            result += ch
    return result

# 276 
def same_chars(s0, s1):
    set0 = set(s0.charAt(i) for i in range(len(s0)))
    set1 = set(s1.charAt(i) for i in range(len(s1)))
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
def correctBracketing(brackets, depth=0):
    for b in brackets:
        if b == '(':
            depth += 1
        elif b == ')':
            depth -= 1
        if depth < 0:
            return False
    return depth == 0

# 279 
def circular_shift(x, shift):
    xs = str(x)
    if shift > len(xs):
        return xs[::-1][:shift] + xs[:shift]
    return xs[:shift] + xs[len(xs)-shift:]

# 280 
def search(lst):
    counter = {}
    for i in lst:
        counter[i] = counter.get(i, 0) + 1
    ans = -1
    for item in counter.entrySet():
        if item.getValue() >= item.getKey() and item.getKey() > ans:
            ans = item.getKey()
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
        if s[i] == s[i+1] or s[i] == s[i+2] or s[i+1] == s[i+2]:
            return False
    return True

# 284 
numerical_letter_grade = lambda gpa : 'A+' if gpa == 4.0 else 'A' if gpa > 3.7 else 'A-' if gpa > 3.3 else 'A' if gpa > 2.7 else 'B+' if gpa > 2.3 else 'B' if gpa > 2.0 else 'B-' if gpa > 1.7 else 'C+' if gpa > 1.3 else 'C' if gpa > 1.0 else 'D+' if gpa > 0.7 else 'D' if gpa > 0.0 else 'D-' if gpa == 0.0 else 'E'

# 285 
def solve(n):
    bi_str = ''
    sum = 0
    for c in str(n):
        sum += ord(c) - ord('0')
        while sum > 0:
            bi_str += '0' * (sum % 2)
            sum //= 2
    return bi_str

# 286 
def anti_shuffle(s):
    ret = ''
    current = ''
    for i in range(len(s)):
        if i == len(s) or s[i] == ' ':
            char = current[i]
            tmp = sorted(char)
            if not ret or s[i] != ' ':
                ret += ' '
            current = ''
        else:
            current += s[i]
    return ret

# 287 
def sort_array(array):
    if not array:
        return array
    if len(array) % 2 == 1:
        array.sort()
    else:
        array.sort(reverse=True)
    return array

# 288 
def encrypt(s):
    ans = ''
    for c in s:
        if c.isalpha():
            ans += chr(ord('a') + (ord(c) - ord('a') + 4) % 26)
        else:
            ans += c
    return ans

# 289 
def isBored(s):
    is_start = True
    sum = 0
    for i in range(len(s)):
        if s[i] in ['.', '?', '!']:
            is_start = True
        else:
            if is_start:
            if s[i] == ' ':
                continue
            elif s.startswith("I "):
                sum += 1
                is_start = False
    return sum

# 290 
def encode(message):
    vowels = "aeiouAEIOU"
    ret = ""
    for c in message:
        if c.isupper():
            c = chr(ord(c) + 26) if c not in vowels else c
        ret += c
    return ret

# 291 
def sum_of_largest_prime(lst):
    largest = 0
    for n in lst:
        if n > largest:
            prime = True
            for i in range(2, n):
                if n % i == 0:
                    prime = False
            if prime:
                largest = n
    sum = 0
    s = str(largest)
    for i in range(len(s)):
        if s[i] != '0':
            sum += ord(s[i]) - ord('0')
    return sum

# 292 
def check_dict_case(dict):
    if not dict:
        return False
    lower = 0
    upper = 0
    for key in dict.keys():
        for c in key.toCharArray():
            if c.islower():
                lower += 1
            elif c.isupper():
                upper += 1
    return lower + upper == 1

# 293 
def multiply(a, b):
    return abs(a) % 10 * abs(b) % 10

# 294 
def count_upper(s):
    vvowel = "AEIOU"
    count = 0
    for i in range(0, len(s), 2):
        if s[i:i+2] not in vvowel:
            count += 1
    return count

# 295 
from collections import defaultdict

num_to = defaultdict(lambda: 'Unknown', 1:'One', 2:'Two', 3:'Three', 4:'Four', 5:'Five', 6:'Six', 7:'Seven', 8:'Eight', 9:'Nine')
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
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
from collections import defaultdict

def histogram(test):
    histogram = defaultdict(int)
    max = 0
    for i in range(len(test)):
        if test[i] != ' ':
            histogram[test[i]] += 1
            if histogram[test[i]] > max:
                max = histogram[test[i]]
    result = defaultdict(int)
    for item in histogram.items():
        if item.value == max:
            result[item.key] = item.value
    return result

# 299 
def reverse_delete(s, c):
    ret = []
    for ch in s:
        if ch.index(c) == -1:
            ret.append(ch)
    ret_str = ''.join(ret)[::-1]
    flag = False
    if ret_str[::-1] == c:
        flag = True
    return ret, flag

# 300 
def sort_array(arr):
    bin = [0] * len(arr)
    for i in arr:
        b = 0
        n = abs(i)
        while n > 0:
            b += n % 2
            n /= 2
        bin.append(b)
    for i in range(len(arr)):
        for j in range(1, len(arr)):
            if bin[j] < bin[j-1] or bin[j] == bin[j-1]:
                temp = bin[j]
                bin[j] = bin[j-1]
                bin[j-1] = temp
    return arr

# 301 
def get_closest_vowel(word):
    vowels = "AEIOUaeiou"
    for i in range(len(word) - 2, 0, -1):
        if (vowels.index(word[i]) != -1 and vowels.index(word[i+1]) == -1 and vowels.index(word[i-1]) == -1):
            return word[i]
    return ""

# 302 
def match_pairs(lst):
    strings = lst
    for l in strings:
        count = 0
        for c in l:
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
        return arr
    arr.sort()
    return arr[arr.size - k:]

# 304 
def valid_date(date):
    if len(date) != 10:
        return False
    for i in range(10):
        if i == 2 or i == 5:
            if date[i] != '-':
                return False
        elif not char.isdigit(date[i]):
            return False
    month = int(date[0:2])
    day = int(date[3:5])
    year = int(date[6:10])
    if month < 1 or month > 12:
        return False
    if day < 1 or day > 31:
        return False
    if day == 31 and (month == 4 or month == 6 or month == 9 or month == 11 or month == 2):
        return False
    return True

# 305 
def split_words(txt):
    current = ""
    result = []
    if ' ' in txt and txt.index(' ') != -1:
        for i in range(len(txt)):
            if i == len(txt) or txt[i] == ' ':
                if current.length() > 0:
                    result.append(current.tostring())
                current = ""
                current.setlength(0)
            else:
                current.append(txt[i])
    return result

if __name__ == '__main__':
    num = 0
    for c in txt.toCharArray():
        if c.islower() and c % 2 == 0:
            num += 1
    return list(str(num))

# 306 
def tri(n):
    if n == 0:
        return [1]
    tri = []
    tris = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            tri.append(i // 2 + 1)
        else:
            tri.append(tri[i - 1] + tri[i - 2] + (i + 3) // 2)
    return tri

# 307 
def check_if_last_char_is_letter(txt):
    if txt == "":
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
            sum -= 2 * (w[0] - '0')
        result.append(sum)
    return nums

# 309 
planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
idx1 = planets.index("Mercury")
idx2 = planets.index("Earth")

if idx1 == -1 or idx2 == -1 or idx1 == idx2:
    sublist = []
else:
    if idx1 > idx2:
        sublist = planets[idx2 + 1: idx1]
    else:
        sublist = planets[idx1 + 1: idx2]

# 310 
def sorted_list_sum(lst):
    result = []
    for i in lst:
        if len(i) % 2 == 0:
            result.append(i)
    result.sort(key=lambda l, r: (len(l) == len(r)).__lt__())
    return result

# 311 
def cycpattern_check(a, b):
    for i in range(len(b)):
        rotate = b[i:] + b[:i]
        if a in rotate:
            return True
    return False

# 312 
def even_odd_count(num):
    even_count = 0
    odd_count = 0
    for i in str(abs(num)):
        if i % 2 == 0:
            even_count += 1
        else:
            odd_count += 1
    return [even_count, odd_count]

# 313 
def find_max(words):
    max_word = ""
    max_length = 0
    for word in words:
        unique = set(word)
        if len(unique) > max_length:
            max_word = word
            max_length = len(unique)
    return max_word

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
from collections import Counter

def most_frequent(arr, n):
    hp = Counter()
    max_count = 0
    res = -1
    for i in range(n):
        if hp[arr[i]] > 0:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
        if max_count < hp[arr[i]]:
            res = arr[i]
            max_count = hp[arr[i]]
    return res

# 316 
def find(a, b, k, n1, n2):
    s = set()
    for i in range(n2):
        s.add(b[i])
    missing = 0
    for i in range(n1):
        if not s.__contains__(a[i]):
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
        if entry[0] == mp[arr[i]]:
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
def count_triplets(a, n):
    s = set()
    count = 0
    for i in range(n):
        s.add(a[i])
    for i in range(n):
        for j in range(i + 1, n):
            xor = a[i] ^ a[j]
            if xor in s and xor != a[i] and xor != a[j]:
                count += 1
    return count / 3

# 320 
def least_frequent(arr, n):
    from collections import Counter
    hp = Counter()
    for i in range(n):
        if hp[arr[i]] == 1:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
    min_count = n + 1
    res = -1
    for entry in hp.items():
        if min_count >= entry.value:
            res = entry.key
            min_count = entry.value
    return res

# 321 
def findPermutations(arr):
    cnt = 0
    max_ind = -1
    min_ind = 1000000
    n = len(arr)
    index_of = {}
    for i in range(n):
        index_of[arr[i]], i + 1
    for i in range(1, n + 1):
        max_ind = max(max_ind, index_of.get(i, 0))
        min_ind = min(min_ind, index_of.get(i, 0))
        if max_ind - min_ind + 1 == i:
            cnt += 1
    return cnt

# 322 
def formQuadruplets(arr, n):
    ans = 0
    pairs = n // 4
    arr.sort(reverse=True)
    for i in range(pairs):
        ans += arr[i + 2]
    return ans

# 323 
def lexicographically_maximum(s, n):
    m = {}
    v = []
    for i in range(n):
        if m.get(s[i]):
            v.append(i)
        else:
            m[s[i]] = m.get(s[i]) + 1
    l = 0
    for i in range(n - 1, -1, -1):
        if l > i:
            break
    if i < 0:
        m[s[i]] = m.get(s[i]) - 1
        s = s[0:i+1] + v.get(i)
        l += 1
    return s

# 324 
def noOfValidK(k, arr):
    s = set()
    count = 0
    while k != 0:
        s.add(k % 10)
        k = k // 10
        flag = True
        no = arr[count]
        while no != 0:
            digit = no % 10
            if not s.issubset(digit):
                flag = False
                break
            no = no / 10
        if flag:
            count += 1
    return count

# 325 
def del_cost(s, cost):
    ans = 0
    forMax = {}
    forTot = {}
    for i in range(len(s)):
        if not forMax.get(s[i]) in cost:
            forMax[s[i]] = cost[i]
        else:
            forTot[s[i]] = max(cost.get(i), forMax.get(s[i]))
    return ans

# 326 
def replace_duplicates(names):
    hash_map = {}
    for i in range(len(names)):
        if names[i] not in hash_map:
            hash_map[names[i]] = 1
        else:
            count = hash_map[names[i]]
            hash_map[names[i]] = count + 1
            names[i] = str(count)
    return names

# 327 
matrix = [ [ [ int(x) for x in range(5) ] for _ in range(5) ] for _ in range(5) ] for _ in range(5) ]
res = []
for i in range(len(matrix)):
    set_ = set()
    for j in range(len(matrix[i])):
        minR = float('inf')
        for k in range(len(matrix[i][j])):
            minR = min(minR, matrix[i][j][k])
        set_.add(minR)
for j in range(len(matrix[0])):
    maxC = float('-inf')
    for i in range(len(matrix)):
        maxC = max(maxC, matrix[i][j])
    if set_.__contains(maxC):
        res.append(maxC)
return res

# 328 
from collections import defaultdict

def lengthOfLongestAP(a, n):
    dp = defaultdict(lambda: defaultdict(int))
    res = 2
    for i in range(n):
        for j in range(i+1, n):
            d = a[j] - a[i]
            if dp.get(d):
                if dp[d].get(i):
                    dp[d].put(j, dp[d].get(i) + 1)
                else:
                    dp[d].put(j, 2)
            else:
                res = max(res, dp.get(d).get(j))
    return res

# 329 
def findKthChar(n, k):
    prev = 'A'
    cur = ''
    if n == 1:
        return 'A'
    for j in range(2, n+1):
        cur = prev + 'B'
        for i in range(prev.length()):
            if prev[i] == 'A':
                prev = prev[:i] + 'B' + prev[i+1:]
            else:
                prev = prev[:i] + 'A' + prev[i+1:]
    return cur[k-1]

# 330 
def find_kth_largest(s, k):
    tmp = s.chars()
    tmp = {e: tmp.count(e) for e in tmp}
    tmp = sorted(tmp.items(), key=tmp.get, reverse=True)
    return tmp[k-1]

# 331 
from collections import defaultdict

def subArraylen(arr, n, k):
    mp = defaultdict(int)
    mp[0] = 0
    for i in range(1, n):
        arr[i] = arr[i] + arr[i-1]
        if arr[i] < k:
            continue
        else:
            x = arr[i] - k
            if x == 0:
                len_ = i
            elif not mp.keys().__contains(x):
                len_ = i - mp[x]
            else:
                len_ = min(len_, i)
        return len_

# 332 
def findMaxLen(a, k):
    n = len(a)
    a.sort()
    vis = [False]*n
    mp = {}
    for i in range(n):
        mp[a[i]*k] = i
    c = 0
    for i in range(n):
        if not vis[i]:
            check = a[i]*k
            if mp.get(check):
                c += 1
                vis[mp.get(check)] = True
    return n - c

# 333 
from collections import deque

def minDistancePoints(a, k, n):
    m = {}
    q = deque()
    ans = []
    for i in range(n):
        m[a[i]].get(i, 1)
        q.append(a[i])
    while k > 0:
        x = q.poll()
        if not m.containsKey(x - 1) and k > 0:
            m[x - 1] = 1
            q.add(x - 1)
            ans.append(x - 1)
            k -= 1
        if not m.containsKey(x + 1) and k > 0:
            m[x + 1] = 1
            q.add(x + 1)
            ans.append(x + 1)
            k -= 1
    return ans

# 334 
def is_valid_len(s, length, k):
    n = s.length()
    mp = {}
    right = 0
    while right < length:
        if mp.get(s[right]):
            mp[s[right]] = mp.get(s[right]) + 1
        else:
            mp[s[right]] = 1
        right += 1
    if len(mp) <= k:
        return True
    while right < n:
        if mp.get(s[right]):
            mp[s[right]] = mp.get(s[right]) + 1
        else:
            mp[s[right]] = 1
        if mp.get(s[right - length]) == 0:
            mp.remove(s[right - length])
        if mp.get(s[right - length]) == 0:
            mp.put(s[right], mp.get(s[right - length]) + 1)
        right += 1
    if len(mp) <= k:
        return True
    return False

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
        m[strs[i]], i+1
    if s in m:
        return 0
    score = 0
    for i in range(len(s)):
        score += ord(s[i]) - ord('a') + 1
    score *= m.get(s)
    return score

# 337 
from collections import defaultdict

def countEle(s, a, n):
    mp = defaultdict(bool)
    ans = []
    for i in range(n):
        num = a[i]
        if mp[num]:
            ans.append(0)
        else:
            cnt = 0
            while s.get(0) != num:
                mp[num] = True
                s.remove(0)
                cnt += 1
            ans.append(cnt)
    return ans

# 338 
from collections import Counter
import math

def maxDistinctChar(s, n, k):
    freq = Counter(s)
    v = []
    for i in range(n):
        if freq[s[i]] == 1:
            freq[s[i]] += 1
        else:
            freq[s[i]] = 1
        v.append(freq[s[i]])
    v = sorted(v)
    res = 0
    for i in range(len(v)):
        if v[i] == 1:
            res += 1
    return res

# 339 
def findKth(arr, n, k):
    missing = set()
    count = 0
    maxM = max(arr)
    minM = min(arr)
    for i in range(minM + 1, maxM + 1):
        if not missing.add(arr[i])
        count += 1
        if count == k:
            return i
    return -1

# 340 
def almost_sort(a, n):
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
    freq = [0]*256
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
from collections import defaultdict

def find_min_operations(arr, N, K):
    operations = 0
    freq = defaultdict(int)
    for i in range(K):
        for j in range(N):
            freq[arr[j]] += 1
    max1 = 0
    num = 0
    for entry in freq.items():
        if entry.value > max1:
            max1 = entry.value
            num = entry.key
    for i in range(K):
        if arr[i] != num:
            operations += 1
    return operations

# 343 
def substring(s, n):
    v = []
    for i in range(n):
        for len in range(1, n - i + 1):
            find = s[i: i + len]
            v.append(find)
    return v

# 344 
def check_unique_frequency(arr, n):
    from collections import Counter
    freq = Counter(arr[:n])
    unique_freq = set()
    for i in range(n):
        if freq[arr[i]] == 1:
            return False
        else:
            unique_freq.add(arr[i])
    return True

# 345 
def min_cost(str1, str2, n):
    cost = 0
    tmp = str1.toCharArray()
    for i in range(n):
        if tmp[i] != str2.charAt(i):
            if i < n - 1 and tmp[i + 1] != str2.charAt(i + 1):
                c = tmp[i]
                tmp[i] = tmp[i + 1] = c
                cost += 1
            else:
                cost += 1
    return cost

# 346 
def is_valid_num(x):
    mp = {}
    for i in range(x):
        if mp.get(x[i]) or ord(x[i]) > 5:
            return False
        mp[x[i]] = 1
    return True

# 347 
def minimize_diff(arr, n, k):
    max_val = max(arr)
    min_val = min(arr)
    if (max_val - min_val <= k):
        return max_val - min_val
    avg = (max_val + min_val) // 2
    for i in range(n):
        if (arr[i] > avg):
            arr[i] = arr[i] - k
        else:
            arr[i] = arr[i] + k
    max_val = max(arr)
    min_val = min(arr)
    return max_val - min_val

# 348 
def get_min_cost(arr, n):
    min_ele = min(arr)
    return min_ele * (n - 1)

# 349 
def possibility(m, length, s):
    countOdd = 0
    for i in range(length):
        if (m.get(s[i]) == '0') & 1:
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
    res += total * vert
    total = 0
    while j < n:
        total += y[j]
    res += total * hzntl
    return res

# 351 
from collections import defaultdict

def find_maximum_score(a, n):
    freq = defaultdict(int)
    for i in range(n):
        if freq[a[i]]:
            freq[a[i]] += 1
        else:
            freq[a[i]] = 1
    dp = [0] * (max(a) + 1)
    dp[0] = 0
    dp[1] = freq.get(1, 0)
    for i in range(2, dp[-1] + 1):
        dp[i] = max(dp[i - 1], dp[i - 2] + freq.get(i, 0) * i)
    return dp[dp.__len__() - 1]

# 352 
def countWays(s, t, k, mod):
    n = len(s)
    a, b = 0, 0
    for i in range(n):
        p = s[i:n] + s[0:i]
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
        dp2[i] = (dp1[i - 1] * (b) % mod + dp2[i - 1] * (b - 1) % mod) % mod
    return dp1[k]

# 353 
def find_subarray_sum(arr, n, k):
    prev_sum = {}
    result = 0
    current_sum = 0
    for i in range(n):
        current_sum += arr[i]
        if current_sum == k:
            result += 1
        if prev_sum.get(current_sum - k) :
            result += prev_sum.get(current_sum - k, 0)
        prev_sum[current_sum] = prev_sum.get(current_sum, 0) + 1
    return result

# 354 
def maximum_occurrence(s):
    n = len(s)
    freq = {}
    answer = float('-inf')
    for i in range(n):
        temp = ""
        temp += s[i]
        freq[temp] = freq.get(temp, 0) + 1
    for i in range(n):
        for j in range(i + 1, n):
            temp = ""
            temp += s[i]
            temp += s[j]
            freq[temp] = freq.get(temp, 0) + 1
    for entry in freq.entrySet():
        answer = max(answer, entry.get())
    return answer

# 355 
def count_characters(strings, chars):
    res = 0
    freq = {}
    for st in strings:
        for c in st:
            if c in chars:
                freq[c] = freq.get(c, 0) + 1
    for st in strings:
        flag = True
        for c in st.toCharArray():
            if not freq.get(c):
                flag = False
                break
        if flag:
            res += len(st)
    return res

# 356 
def distinct_substring(p, q, k, n):
    ss = set()
    for i in range(n):
        sum = 0
        s = ""
        for j in range(n):
            pos = p[j] - 'a'
            sum += q[pos] - '0'
            s += p[j]
            if sum <= k:
                ss.add(s)
            else:
                break
    return len(ss)

# 357 


# 358 
def count_substrings(s, k):
    n = len(s)
    answer = 0
    map = {}
    for i in range(n):
        if s[i] not in map:
            map[s[i]] = 1
        else:
            map[s[i]] = map[s[i]] + 1
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
    for h in m.entrySet():
        if h.getValue() % 2 != 0:
            p += 1
    if k < p:
        return False
    return True

# 360 
def equal_ignore_case(str1, str2):
    return str1.lower() == str2.lower()

# 361 
def findLongestSubstring(s):
    n = len(s)
    i = 0
    sum = 0
    max_len = 0
    prev_sum = {}
    while i < n:
        if s[i] == '1':
            sum += 1
        else:
            sum -= 1
        if sum > 0:
            curr_len = i + 1
            max_len = max(max_len, curr_len)
        else:
            if prev_sum.get(sum - 1):
                curr_len = i - prev_sum.get(sum - 1)
                max_len = max(max_len, curr_len)
        if not prev_sum.get(sum):
            prev_sum[sum] = i
        return max_len

# 362 
def hasAllCodes(s, k):
    us = set()
    for i in range(len(s) - k + 1):
        us.add(s[i:i+k])
    return len(us) == 1 << k

# 363 
def check_palindrome(word):
    word = word.lower()
    n = len(word)
    for i in range(n):
        if word[i] != word[n-1]:
            return False
    return True

# 364 
def convert(st):
    w, z = "", ""
    st = st.upper() + " "
    for i in range(len(st)):
        ch = st[i]
        if ch != ' ':
            w += ch
        else:
            z += ch.lower() + w[0] + st[1:] + " "
            w = ""
    return z

# 365 
def max_lines(n, x1, y1, x2, y2):
    s = set()
    slope = float('inf')
    for i in range(n):
        if x1[i] == x2[i]:
            slope = max(slope, (y2[i] - y1[i]) * 1.0 / (x2[i] - x1[i]))
        else:
            slope = float('inf')
    return len(s)

# 366 
from collections import defaultdict
import math

def PrimeFactor(n):
    primef = defaultdict(int)
    while n % 2 == 0:
        if primef.get(2):
            primef[2] = primef.get(2) + 1
        n /= 2
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        while n % i == 0:
            if primef.get(i):
                primef[i] = primef.get(i) + 1
            n /= i
    if n > 2:
        primef[n] = 1
    return primef

# 367 
def is_divisible(s, d):
    hash_map = set()
    hash_map.add(s)
    for i in range(0, d+1):
        s += s % d
        if hash_map.__contains__(s):
            if s == 0:
                return "Yes"
            else:
                hash_map.add(s)
    return "No"

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
    days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 31, 31, 28]
    year = int(date[0:4])
    month = int(date[5:7])
    day = int(date[8:])
    if month > 2 and year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
        day += 1
    while month > 1:
        day += days[month - 2]
        month -= 1
    return day

# 370 
def isPerfectSquare(arr, n):
    from collections import defaultdict
    map_ = defaultdict(int)
    for i in range(n):
        map_[arr[i]].append(i)
    for i in range(n):
        if map_[arr[i]].get(i, 0) % 2 == 1:
            return False
    return True

# 371 
def minMoves(n, s):
    ans = int(s)
    length = len(s)
    for i in range(length):
        for j in range(length):
            if i == j:
                continue
            char = s[i]
            t = s[j]
            if char == '0':
                pos = -1
                for k in range(i):
                    if k < length - 1:
                        pos = k
                        break
            if pos == -1:
                return -1
            return ans

# 372 
def minimum_operations(a, n):
    mp = {}
    for i in range(n):
        mp[a[i]] = mp.get(a[i], 0) + 1
    count = 0
    for entry in mp.items():
        if entry.get() > 1:
            count += entry.get() - 1
    return count

# 373 
def kaprekarRec(n, prev):
    if n == 0:
        return 0
    prev = n
    digits = [4]
    for i in range(4):
        digits[i] = n % 10
        n = n // 10
    digits.sort()
    asc = 0
    for i in range(4):
        asc = asc * 10 + digits[i]
    digits.sort()
    desc = 0
    for i in range(3, -1, -1):
        desc = desc * 10 + digits[i]
    diff = abs(asc - desc)
    if diff == prev:
        return diff
    return kaprekarRec(diff, prev)

# 374 
def fractionToDecimal(n, d):
    res = ""
    mp = {}
    rem = n % d
    while rem != 0 and not mp.get(rem):
        mp[rem] = res.length()
        res += str(rem // d)
        rem = rem * 10
        if rem == 0:
            return ""
        elif mp.get(rem):
            return res[mp.get(rem)]
    return ""

# 375 
def isFancy(num):
    fp = {}
    fp['0'] = '0'
    fp['1'] = '1'
    fp['6'] = '6'
    fp['8'] = '8'
    fp['9'] = '9'
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
    odd_numbers = len(list(filter(lambda n: n % 2 == 1, numbers)))
    return odd_numbers / distinct_count

# 377 
def compare_sum(numbers, words):
    number_sum = sum(numbers)
    word_length_sum = sum(map(len, words))
    if number_sum < word_length_sum:
        return -1
    elif number_sum > word_length_sum:
        return 1
    else:
        return 0

# 378 
def all_longer_than(short_words, long_words):
    max_of_short = len(short_words)
    min_of_long = len(long_words)
    return min_of_long > max_of_short

# 379 
def compare_odd_even_range(numbers):
    range_odd = numbers.stream().filter(lambda n: n%2==1).map(lambda n: n).max()
    range_even = numbers.stream().filter(lambda n: n%2==0).map(lambda n: n).min()
    
    if range_odd < range_even:
        return -1
    elif range_odd > range_even:
        return 1
    else:
        return 0

# 380 
def average_distinct_length(words):
    average_len = len(set(words))
    return average_len

# 381 
def withDrawBalance(start, withdrawals):
    balance = start
    end = withdrawals.stream().reduce(start, (balance, nextWithdrawal) -> nextWithdrawal <= balance, balance - nextWithdrawal)
    return end

# 382 
def first_short_and_starts_with_o(words):
    matched_element = next((w for w in words if len(w) < 5 and w[0] == 'o'), words), "")
    return matched_element

# 383 
def big_number_at_index(numbers, index):
    target_num = next((n for n in numbers if n > 5), None)
    return target_num

# 384 
def contains_square_in_range(range_start, range_length):
    contains_square = any(n for n in range(range_start, range_start + range_length) if n == int(pow(int(pow(n, 2)), 2)) == n)
    return contains_square

# 385 
from collections import defaultdict

def groupNumbersByMod(numbers, mod):
    number_groups = defaultdict(list)
    for number in numbers:
        key = number % mod
        number_groups[key].append(number)
    return dict(number_groups)

# 386 
from collections import defaultdict

def group_words_by_first_char(words):
    word_groups = defaultdict(list)
    for word in words:
        word_groups[word[0]].append(word)
    return word_groups

# 387 
def order_by_length_and_descending(words):
    sorted_words = sorted(words, key=lambda word: (len(word), word), reverse=True)
    return sorted_words

# 388 
def order_first_char_descending_reverse(words):
    sorted_words = sorted(words, key=lambda w: w[0], reverse=True)
    return sorted_words[::-1]

# 389 
def get_sublist_of_negative(numbers, start, length):
    return numbers[start:start+length] if any(n < 0 for n in numbers[start:start+length]) else None

# 390 
def get_positive_sequence(numbers):
    sub_sequence = numbers.stream().dropwhile(lambda n: n <= 0).takewhile(lambda n: n >= 0).collect(list)
    return sub_sequence

# 391 
def get_larger_than_index_sequence(numbers):
    from itertools import count
    from operator import ge
    sub_sequence = [num for i in count() if next(num) < i and num >= i]
    return sub_sequence

# 392 
def rearrange_word_by_indexes(words, indexes):
    new_indexes = indexes
    new_words = [words[i] for i in new_indexes]
    return new_words

# 393 
def get_words_upper_lower(words):
    upper_lower_words = words.stream().map(lambda w: [w.upper(), w.lower()]).collect(Collectors.to_list())
    return upper_lower_words

# 394 
def select_if_in_place(numbers):
    nums_in_place = list(range(0, len(numbers)))
    nums_in_place = [numbers[i] == i for i in nums_in_place]
    return nums_in_place

# 395 
from itertools import combinations

def select_pairs(numbersA, numbersB):
    pairs = numbersA.stream().flat_map(lambda a: numbersB.stream().filter(lambda b: a < b).map(lambda b: [a, b]).collect(Collectors.to_list())).to_list()
    return pairs

# 396 
def string_cross_join(end_words, begin_words):
    cross_strings = begin_words.stream().flatMap(lambda b: end_words.stream().filter(lambda e: b.charAt(0) == e.charAt(0) and len(b) - 1 == e.length() - 1).map(lambda e: e + " " + b).collect(Collectors.toList())
    return cross_strings

# 397 
def elements_contain_subword(words, subword):
    if any(word for word in words if len(word) <= 5 and subword in word):
        return 1
    elif any(word for word in words if len(word) <= 5 and subword in word):
        return 0
    else:
        return -1

# 398 
def concat_large_numbers(numbersA, numbersB, flag):
    from itertools import chain
    all_numbers = list(chain(numbersA, numbersB))
    all_numbers = [n for n in all_numbers if n > flag]
    return all_numbers

# 399 
def dot_product(vectorA, vectorB):
    dot_product = sum(i*vectorA[i]*vectorB[i] for i in range(len(vectorA)))
    return dot_product

# 400 
setA = set([1, 2, 3, 4])
setB = set([3, 4, 5, 6])
difference = setA.difference(setB)
difference.addAll(setB)
intersection = setA.intersection(setB)
intersection.retainAll(setB)
difference.removeAll(intersection)
difference = sorted(difference)
return difference

# 401 


