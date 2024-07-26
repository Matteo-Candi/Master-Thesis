# 1 
def greatest_common_divisor(a, b):
    if a == 0 or b == 0:
        return a + b
    if a == b:
        return a
    if a > b:
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
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            q = i
            while q > 0:
                if q % 10 == 7:
                    count += 1
                q //= 10
    return count

# 5 
def prime_fib(n):
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
    return a * h / 2

# 7 
def modp(n, p):
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
    for i in range(2, n):
        while n % i == 0 and n > i:
            n //= i
    return n

# 11 
def sum_to_n(n):
    result = 0
    for i in range(1, n + 1):
        result += i
    return result

# 12 
def fibfib(n: int):
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
        while a % i == 0 and a >= i:
            a //= i
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
        return - 1
    if y % 2 == 0:
        return y
    if x == y:
        return - 1
    return y - 1

# 16 
def is_equal_to_sum_even(n):
    return n % 2 == 0 and n >= 8

# 17 
def special_factorial(n):
    fact = 1
    special_fact = 1
    for i in range(1, n + 1):
        fact *= i
        special_fact *= fact
    return special_fact

# 18 
def x_or_y(n, x, y):
    is_prime = n >= 2
    for i in range(2, n):
        if n % i == 0:
            is_prime = False
            break
    if is_prime:
        return x
    return y

# 19 
def right_angle_triangle(a, b, c):
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
def find_sum(n):
    ans = 0
    temp = 0
    for i in range(1, n + 1):
        if not temp < n:
            break
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
    gap = gap * 10 // 13
    if gap < 1:
        return 1
    return gap

# 24 
def count_non_decreasing(n):
    k = 10
    count = 1
    for i in range(1, n + 1):
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
    else:
        if y > 0:
            return x * temp * temp
        else:
            return temp * temp / x

# 27 
def multiply(x, y):
    if y == 0:
        return 0
    if y > 0:
        return x + multiply(x, y - 1)
    if y < 0:
        return - multiply(x, - y)

# 28 
def smallest(x, y, z):
    if not y // x:
        return y if(not y // z) else z
    return x if(not x // z) else z

# 29 
def is_power_of_four(n):
    if n == 0:
        return False
    while n != 1:
        if n % 4 != 0:
            return False
        n = n // 4
    return True

# 30 
def mod_inverse(a, m):
    m0 = m
    x0, x1 = 0, 1
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

# 31 
def cnt_rotations(s, n):
    s2 = s + s
    pre = [0] * (2 * n)
    for i in range(2 * n):
        if i != 0:
            pre[i] += pre[i - 1]
        if s2 [i] == 'a' or s2 [i] == 'e' or s2 [i] == 'i' or s2 [i] == 'o' or s2 [i] == 'u':
            pre[i] += 1
    ans = 0
    for i in range(n - 1, 2 * n - 1):
        r, l = i, i - n
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
            if(s[i] != temp[i]):
                return False
        return True

# 34 
def lexicographically_smallest_string(s, n):
    last_ze = - 1
    ans = ""
    for i in range(n - 1, - 1, - 1):
        if s[i] == '0':
            last_ze = i
            break
    for i in range(n):
        if i <= last_ze and s[i] == '0':
            ans += s[i]
        elif i > last_ze:
            ans += s[i]
    return ans

# 35 
def calculate_max(n, m, k):
    ans = - 1
    low, high = 0, m
    while low <= high:
        mid = (low + high) // 2
        val = 0
        l = k - 1
        r = n - k
        val += mid
        if mid >= l:
            val += l * (2 * mid - l - 1) / 2
        else:
            val += mid * (mid - 1) / 2 + (l - mid)
        if mid >= r:
            val += r * (2 * mid - r - 1) / 2
        else:
            val += mid * (mid - 1) / 2 + (r - mid)
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
    if n <= 1:
        return False
    if n <= 3:
        return False
    if n % 2 == 0 or n % 3 == 0:
        return True
    for i in range(5, n + 1, 6):
        if i * i > n:
            break
        if n % i == 0 or n % (i + 2) == 0:
            return True
    return False

# 39 
def min_deletion(s):
    n = len(s)
    first_idx1 = - 1
    last_idx0 = - 1
    for i in range(0, n):
        if s[i] == '1':
            first_idx1 = i
            break
    for i in range(n - 1, - 1, - 1):
        if s[i] == '0':
            last_idx0 = i
            break
    if first_idx1 == - 1 or last_idx0 == - 1:
        return 0
    count1, count0 = 0, 0
    for i in range(0, last_idx0):
        if s[i] == '1':
            count1 += 1
    for i in range(first_idx1 + 1, n):
        if s[i] == '1':
            count0 += 1
    return min(count0, count1)

# 40 
def min_steps(s, n):
    cost = 0
    f = [0] * 26
    for i in range(n):
        curr_ele = ord(s[i]) - ord('a')
        smaller = 0
        for j in range(curr_ele + 1):
            if f[j] != 0:
                smaller += f[j]
        if smaller == 0:
            cost += i + 1
        else:
            cost += i - smaller + 1
        f[ord(s[i]) - ord('a')] += 1
    return cost

# 41 
def number_of_ways(n):
    count = 0
    for a in range(1, n):
        for b in range(1, n):
            c = n - (a + b)
            if a < b + c and b < a + c and c < a + b:
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
def count_max_set_bits(left, right):
    while(left | (left + 1)) <= right:
        left |= left + 1
    return left

# 45 
def find_s(s):
    l = 1
    r = s // 2 + 1
    while l <= r:
        mid = (l + r) // 2
        sum = mid * (mid + 1) / 2
        if sum == s:
            return mid
        elif sum > s:
            r = mid - 1
        else:
            l = mid + 1
    return - 1

# 46 
def check(s):
    min = sys.maxsize
    max = - sys.maxsize
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
    e_sum = max * (max + 1) // 2 - min * (min + 1) // 2
    return sum == e_sum

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
            return(i - 1) * (i - 1) + 1 + (j - 1)
    else:
        if j % 2 == 0:
            return(j - 1) * (j - 1) + 1 + (i - 1)
        else:
            return j * j - (i - 1)

# 49 
def find_min_operations_req_emp_str(s):
    cnt_one = 0
    cnt_zero = 0
    n = len(s)
    for i in range(n):
        if s[i] == '0':
            if cnt_one > 0:
                cnt_one = cnt_one - 1
            cnt_zero = cnt_zero + 1
        else:
            if cnt_zero > 0:
                cnt_zero = cnt_zero - 1
            cnt_one = cnt_one + 1
    return cnt_one + cnt_zero

# 50 
def is_reachable(x1, y1, x2, y2):
    while x2 > x1 and y2 > y1:
        if x2 > y2:
            x2 %= y2
        else:
            y2 %= x2
    if x2 == x1:
        return y2 - y1 >= 0 and(y2 - y1) % x1 == 0
    elif y2 == y1:
        return x2 - x1 >= 0 and(x2 - x1) % y1 == 0
    else:
        return False

# 51 
def find_max_soln(n, x, y):
    ans = - sys.maxsize
    for k in range(n + 1):
        if k % x == y:
            ans = max(ans, k)
    return ans if ans >= 0 and ans <= n else - 1

# 52 
def number_of_pairs(n):
    count = 0
    i = 1
    j = n - 1
    while i < j:
        if(i + j) == n:
            count += 1
        i += 1
        j -= 1
    return count

# 53 
def min_changes(s, n):
    count, zeros, ones = 0, 0, 0
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
def bin_coff(n, r):
    val = 1
    if r > (n - r):
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
    while val:
        d = val % 10
        mask |= (1 << d)
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
    elif last_bit != 1:
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
def find_golomb(n):
    if n == 1:
        return 1
    return 1 + find_golomb(n - find_golomb(find_golomb(n - 1)))

# 61 
def all_ones(s, n):
    co = 0
    for i in range(len(s)):
        co += 1 if s[i] == '1' else 0
    return co == n

# 62 
def pad(n):
    p_prev_prev, p_prev, p_curr, p_next = 1, 1, 1, 1
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
    return "".join(s)

# 65 
def total_hamming_distance(n):
    i, sum = 1, 0
    while n // i > 0:
        sum = sum + n // i
        i = i * 2
    return sum

# 66 
def check_bitonic(s):
    i = 1
    for i in range(1, len(s)):
        if s[i] > s[i - 1]:
            continue
        if s[i] <= s[i - 1]:
            break
    if i == len(s) - 1:
        return 1
    j = i + 1
    for j in range(i + 1, len(s)):
        if s[j] < s[j - 1]:
            continue
        if s[j] >= s[j - 1]:
            break
    i = j
    if i != len(s) - 1:
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
def get_sum(n, d):
    if n < d:
        return 0
    while n % 10 != d:
        n -= 1
    k = n // 10
    return(k + 1) * d + (k * 10 + 10 * k * k) // 2

# 69 
def balanced_string_by_swapping(s):
    unbalanced_pair = 0
    for i in range(len(s)):
        if unbalanced_pair > 0 and s[i] == ']':
            unbalanced_pair -= 1
        elif s[i] == '[':
            unbalanced_pair += 1
    return(unbalanced_pair + 1) // 2

# 70 
def compute_hash(s):
    p = 31
    mod = 10 ** 9 + 7
    hash_val = 0
    mul = 1
    for ch in s:
        hash_val = (hash_val + (ord(ch) - ord('a') + 1) * mul) % mod
        mul = mul * p % mod
    return hash_val

# 71 
def count_of_substring_with_only_ones(s):
    res, count = 0, 0
    for i in range(len(s)):
        count = count + 1 if s[i] == '1' else 0
        res = res + count
    return res

# 72 
def composite(n):
    flag = 0
    c = 0
    for j in range(1, n + 1):
        if n % j == 0:
            c += 1
    if c >= 3:
        flag = 1
    return flag

# 73 
def is_div_by_six(s, n):
    sum = 0
    for i in range(n):
        sum += ord(s[i]) - ord('a') + 1
    if sum % 3 != 0:
        return False
    last_digit = (ord(s[n - 1]) - ord('a') + 1) % 10
    if last_digit % 2 != 0:
        return False
    return True

# 74 
def is_redundant_braces(s):
    a, b = 0, 0
    for i in range(len(s)):
        if s[i] == '(' and s[i + 2] == ')':
            return True
        if s[i] == '*' or s[i] == '+' or s[i] == '-' or s[i] == '/':
            a += 1
        if s[i] == '(':
            b += 1
    if b > a:
        return True
    return False

# 75 
def count_sub_str(s, n):
    count = 0
    i = 0
    while i < (n - 2):
        if s[i] == '0' and s[i + 1] == '1' and s[i + 2] == '0':
            count += 1
            i += 3
        elif s[i] == '1' and s[i + 1] == '0' and s[i + 2] == '1':
            count += 1
            i += 3
        else:
            i += 1
    return count

# 76 
def prefix_occurrences(s):
    c = s[0]
    count_c = 0
    for i in range(len(s)):
        if s[i] == c:
            count_c += 1
    return count_c

# 77 
def is_valid(s, len):
    for i in range(1, len):
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
    d[0] = ord(s2 [0]) - ord(s1 [0])
    for i in range(1, len1):
        if s1 [i] > s2 [i]:
            return False
        else:
            d[i] = ord(s2 [i]) - ord(s1 [i])
    for i in range(len1 - 1):
        if d[i] < d[i + 1]:
            return False
    return True

# 81 
def is_in_given_base(s, bas):
    if bas > 16:
        return False
    elif bas <= 10:
        for i in range(len(s)):
            if not(ord(s[i]) >= ord('0') and ord(s[i]) < ord('0') + bas):
                return False
    else:
        for i in range(len(s)):
            if not((ord(s[i]) >= ord('0') and ord(s[i]) < ord('0') + bas) or(ord(s[i]) >= ord('A') and ord(s[i]) < (ord('A') + bas - 10))):
                return False
    return True

# 82 
def count_non_empty_substr(s):
    n = len(s)
    return n * (n + 1) // 2

# 83 
def even_decimal_value(s, n):
    result = 0
    for i in range(n):
        for j in range(i, n):
            decimal_value = 0
            power_of_2 = 1
            for k in range(i, j + 1):
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
def xor_zero(s):
    one_count = 0
    zero_count = 0
    n = len(s)
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
    for j in range(len(n) - 1, - 1, - 1):
        res += n[j]
    return res

# 87 
def count_substring_with_equal_ends(s):
    result = 0
    n = len(s)
    for i in range(n):
        for j in range(i, n):
            if s[i] == s[j]:
                result = result + 1
    return result

# 88 
def normal_slope(a, b, x1, y1):
    g = a / 2
    f = b / 2
    if g - x1 == 0:
        return - 1
    slope = (f - y1) / (g - x1)
    if slope == 0:
        return - 2
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
    semi_circle_area = (3.14 * (a * a) / 8)
    shaded_area = 4 * semi_circle_area - sq_area
    return shaded_area

# 91 
def factorial(a, b):
    res = 1
    for i in range(1, a + b + 1):
        res = res * i
    for i in range(1, a + 1):
        res = res // i
    for i in range(1, b + 1):
        res = res // i
    return res

# 92 
def factor_tree(n):
    height = 0
    while n > 1:
        flag = False
        for i in range(2, int(math.sqrt(n)) + 1):
            if n % i == 0:
                n = n // i
                flag = True
                break
        height += 1
        if not flag:
            break
    return height

# 93 
def find_if_possible(n, s, x):
    if s >= x and s % 2 == x % 2:
        if n >= 3:
            return "Yes"
        if n == 1:
            if s == x:
                return "Yes"
            else:
                return "No"
        if n == 2:
            c = (s - x) // 2
            a = c
            b = c
            a = a + x
            if(a ^ b) == x:
                return "Yes"
            else:
                return "No"
    else:
        return "No"

# 94 
def maximum_triplet_xor(a, b, c):
    ans = 0
    for i in range(30, - 1, - 1):
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
    while count + day * (day + 1) // 2 < n:
        count += day * (day + 1) // 2
        day += 1
    for type in range(day, - 1, - 1):
        count += type
        if count >= n:
            return type
    return 0

# 96 
def max_gcd_in_range(l, r):
    ans = 1
    for z in range(r, 0, - 1):
        if r // z - (l - 1) // z > 1:
            ans = z
            break
    return ans

# 97 
def sum_of_digits(n):
    sum = 0
    while n != 0:
        sum += (n % 10)
        n = n // 10
    return sum

# 98 
def is_rep_unit_num(n, b):
    length = 0
    count_one = 0
    while(n != 0):
        r = n % b
        length += 1
        if r == 1:
            count_one += 1
        n = n // b
    return count_one >= 3 and count_one == length

# 99 
def is_straigh_line_num(n):
    if(n <= 99):
        return False
    s = str(n)
    d = ord(s[1]) - ord(s[0])
    for i in range(2, len(s)):
        if ord(s[i]) - ord(s[i - 1]) != d:
            return False
    return True

# 100 
def get_count(d, n):
    no = n // d
    result = no
    for p in range(2, no + 1):
        if p * p > no:
            break
        if no % p == 0:
            while no % p == 0:
                no //= p
            result -= result // p
    if no > 1:
        result -= result // no
    return result

# 101 
def is_even_parity(x):
    parity = 0
    while x != 0:
        if x & 1:
            parity += 1
        x = x >> 1
    if parity % 2 == 0:
        return True
    else:
        return False

# 102 
def is_perfect(n):
    sum = 1
    for i in range(2, n + 1):
        if i * i > n:
            break
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
    return 1 + log_a_to_base_b(a // b, b) if a > (b - 1) else 0

# 104 
def using_binary_search(start, end, n, s):
    if start >= end:
        return start
    mid = start + (end - start) // 2
    total_sum = (n * (n + 1)) // 2
    mid_sum = (mid * (mid + 1)) // 2
    if total_sum - mid_sum <= s:
        return using_binary_search(start, mid, n, s)
    return using_binary_search(mid + 1, end, n, s)

# 105 
def min_int(s):
    s1 = list(s)
    for i in range(len(s)):
        if ord(s1 [i]) >= ord('5'):
            s1 [i] = chr(ord('9') - ord(s1 [i]) + ord('0'))
    if s1 [0] == '0':
        s1 [0] = '9'
    return "".join(s1)

# 106 
def count_triplets(a, b, c):
    ans = 0
    for i in range(1, a + 1):
        for j in range(1, b + 1):
            for k in range(1, c + 1):
                if i * k > j * j:
                    ans += 1
    return ans

# 107 
def topsy_turvy(s):
    for i in range(len(s)):
        if s[i] == '2' or s[i] == '4' or s[i] == '5' or s[i] == '6' or s[i] == '7' or s[i] == '9':
            return False
    return True

# 108 
def sum_of_last_dig(n, m):
    sum = 0
    k = n // m
    arr = [0] * 10
    for i in range(10):
        arr[i] = m * (i + 1) % 10
        sum += arr[i]
    rem = k % 10
    ans = k // 10 * sum
    for i in range(rem):
        ans += arr[i]
    return ans

# 109 
def total_pay(total_items, price_of_one_item, n, m):
    free_items = 0
    actual = 0
    free_items = total_items // (n + m)
    actual = total_items - free_items
    amount = actual * price_of_one_item
    return amount

# 110 
def min_operations(x, y, p, q):
    if y % x != 0:
        return - 1
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
        return - 1
    return a + b

# 111 
def is_mersenne(n):
    while n != 0:
        r = n % 2
        if r == 0:
            return False
        n //= 2
    return True

# 112 
def find_third_digit(n):
    if n < 3:
        return 0
    return 1 if n & 1 else 6

# 113 
def is_odd_length(num):
    count = 0
    while num > 0:
        num = num // 10
        count += 1
    if count % 2 != 0:
        return True
    return False

# 114 
def check_is_possible(l, r, k):
    count = 0
    for i in range(l, r + 1):
        if i % k == 0:
            count += 1
    return count > 1

# 115 
def bytes(kilobytes):
    b = kilobytes * 1024
    return b

# 116 
def octahedral_num(n):
    return n * (2 * n * n + 1) // 3

# 117 
def check_equal(s):
    for i in range(len(s)):
        if s[i] != '1' and s[i] != '0' and s[i] != '8':
            return "No"
    start = 0
    end = len(s) - 1
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
        n //= 10
    return n

# 120 
def count_digit(n):
    if n == 0:
        return 0
    return 1 + count_digit(n // 10)

# 121 
def is_divisible_by_5 (s):
    n = len(s)
    return s[n - 1] == '0' or s[n - 1] == '5'

# 122 
def inv(a, m):
    m0 = m
    x0, x1 = 0, 1
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
        x1 = x1 + m0
    return x1

# 123 
def only_first_and_last_are_set(n):
    if n == 1:
        return True
    if n == 2:
        return False
    return((n - 1) & (n - 2)) == 0

# 124 
def divide(dividend, divisor):
    sign = - 1 if((dividend < 0) ^ (divisor < 0)) else 1
    dividend = abs(dividend)
    divisor = abs(divisor)
    quotient = 0
    temp = 0
    for i in range(31, - 1, - 1):
        if temp + (divisor << i) <= dividend:
            temp += divisor << i
            quotient |= 1 << i
    if sign == - 1:
        quotient = - quotient
    return quotient

# 125 
def find_profession(level, pos):
    if level == 1:
        return 'e'
    if find_profession(level - 1, (pos + 1) // 2) == 'd':
        return 'd' if pos % 2 else 'e'
    return 'e' if pos % 2 else 'd'
DEDENT

# 126 
def has_close_elements(numbers, threshold):
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            distance = abs(numbers[i] - numbers[j])
            if distance < threshold:
                return True
    return False

# 127 
def truncate_number(number):
    return number % 1

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
    for i in range(len(numbers) - 1):
        result.append(numbers[i])
        result.append(delimiter)
    result.append(numbers[- 1])
    return result

# 131 
def sum_product(numbers):
    sum_value = 0
    prod_value = 1
    for n in numbers:
        sum_value += n
        prod_value *= n
    return[sum_value, prod_value]

# 132 
def all_prefixes(string):
    result = []
    for i in range(1, len(string) + 1):
        result.append(string[: i])
    return result

# 133 
def parse_music(music_string):
    current = []
    result = []
    for i in range(len(music_string) + 1):
        if i == len(music_string) or music_string[i] == " ":
            if "".join(current) == "o":
                result.append(4)
            if "".join(current) == "o|":
                result.append(2)
            if "".join(current) == ".|":
                result.append(1)
            current.clear()
        else:
            current.append(music_string[i])
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
            factors.append(i)
            n //= i
        else:
            i += 1
    return factors

# 136 
def concatenate(strings):
    result = []
    for s in strings:
        result.append(s)
    return "".join(result)

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
    for i in range(len(l)):
        if i % 2 == 0:
            result.append(evens[i // 2])
        if i % 2 == 1:
            result.append(l[i])
    return result

# 139 
def decode_cyclic(s):
    output = []
    i = 0
    while i <= len(s) - 3:
        x = s[i + 2] + s[i: i + 2]
        output.append(x)
        i += 3
    return "".join(output) + s[i:]

# 140 
def car_race_collision(n):
    return n ** 2

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
    ret = []
    while x > 0:
        ret.insert(0, str(x % b))
        x //= b
    return "".join(ret)

# 144 
def median(l):
    l.sort()
    if len(l) % 2 == 1:
        return l[len(l) // 2]
    else:
        return(l[len(l) // 2 - 1] + l[len(l) // 2]) / 2.0

# 145 
def decode_shift(s: str):
    result = []
    for ch in s:
        w = (ord(ch) + 21 - ord("a")) % 26 + ord("a")
        result.append(chr(w))
    return "".join(result)

# 146 
def below_threshold(l, t):
    for n in l:
        if n >= t:
            return False
    return True

# 147 
def correct_bracketing(brackets):
    depth = 0
    for b in brackets:
        if b == "<":
            depth += 1
        else:
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
    if s[- 1] == "y" or s[- 1] == "Y":
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
    num1 = []
    num2 = []
    flag = False
    for i in range(len(s)):
        if s[i].isdigit():
            if not flag:
                num1.append(s[i])
            if flag:
                num2.append(s[i])
        elif not flag and len(num1) > 0:
            flag = True
    return n - int("".join(num1)) - int("".join(num2))

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
        r -= 1
    if l == r:
        res.append(lst[l])
    return res

# 155 
def triangle_area(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a:
        return - 1.0
    s = (a + b + c) / 2
    area = math.sqrt(s * (s - a) * (s - b) * (s - c))
    return area

# 156 
def will_it_fly(q, w):
    sum = 0
    for i in range(len(q)):
        if q[i] != q[- i - 1]:
            return False
        sum += q[i]
    return sum <= w

# 157 
def is_cube(a):
    a = abs(a)
    i = round(a ** (1.0 / 3))
    return i ** 3 == a

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
    ans = []
    if dec != 0:
        while dec > 0:
            ans.insert(0, str(dec % 2))
            dec //= 2
    else:
        ans += "0"
    return "db" + "".join(ans) + "db"

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
    return 18 * (10 ** (n - 2))

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
        for j in range(len(lst[i]) - 1, - 1, - 1):
            if lst[i] [j] == x:
                coords.append([i, j])
    return coords

# 164 
def next_smallest(lst):
    lst.sort()
    for i in range(1, len(lst)):
        if lst[i] != lst[i - 1]:
            return lst[i]
    return - 1

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
def make_a_pile(n):
    result = []
    for i in range(n):
        result.append(n + 2 * i)
    return result

# 169 
def words_string(s):
    current = []
    words = []
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == " " or s[i] == ",":
            if len(current) > 0:
                words.append("".join(current))
                current.clear()
        else:
            current.append(s[i])
    return words

# 170 
def rounded_avg(n, m):
    if n > m:
        return - 1
    num = (n + m) // 2
    ret = []
    while num > 0:
        ret.insert(0, str(num % 2))
        num //= 2
    return "".join(ret)

# 171 
def unique_digits(x):
    digits = []
    for n in x:
        is_unique = True
        for c in str(n):
            if ord(c) % 2 == 0:
                is_unique = False
                break
        if is_unique:
            digits.append(n)
    digits.sort()
    return digits

# 172 
def count_nums(arr):
    num = 0
    for n in arr:
        neg = - 1 if n < 0 else 1
        n = abs(n)
        digits = []
        for c in str(n):
            digits.append(ord(c) - ord("0"))
        digits[0] *= neg
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
    if arr[- 1] > arr[0]:
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
            if d.isdigit() and ord(d) % 2 == 1:
                sum += 1
        result = []
        for c in original_str:
            if c == "i":
                result.append(str(sum))
            else:
                result.append(c)
        results.append("".join(result))
    return results

# 176 
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
            res += (sum - 1) // capacity + 1
    return res

# 178 
def select_words(s, n):
    vowels = "aeiouAEIOU"
    current = []
    result = []
    consonant_num = 0
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == " ":
            if consonant_num == n:
                result.append("".join(current))
            current.clear()
            consonant_num = 0
        else:
            current.append(s[i])
            if s[i] not in vowels:
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
        if - 99 <= arr[i] <= 99:
            sum += arr[i]
    return sum

# 181 
def get_odd_collatz(n):
    odd_collatz = []
    while n > 1:
        if n % 2 == 1:
            odd_collatz.append(n)
            n = n * 3 + 1
        else:
            n //= 2
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
    inter1 = max(interval1 [0], interval2 [0])
    inter2 = min(interval1 [1], interval2 [1])
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
        return - 32768
    sum = 0
    prods = 1
    for i in arr:
        sum += abs(i)
        if i == 0:
            prods = 0
        if i < 0:
            prods = - prods
    return sum * prods

# 185 
def minPath(grid, k):
    n = len(grid)
    min_num = 0
    for i in range(n):
        for j in range(n):
            if grid[i] [j] == 1:
                tmp = []
                if i != 0:
                    tmp.append(grid[i - 1] [j])
                if j != 0:
                    tmp.append(grid[i] [j - 1])
                if i != n - 1:
                    tmp.append(grid[i + 1] [j])
                if j != n - 1:
                    tmp.append(grid[i] [j + 1])
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
    prod = 1
    for digit in str(n):
        if ord(digit) % 2 == 1:
            if prod == 0:
                prod == 1
            prod *= ord(digit) - ord("0")
    return prod

# 187 
def is_nested(s):
    count = 0
    max_count = 0
    for ch in s:
        if ch == "[":
            count += 1
        if ch == "]":
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
        sum += math.ceil(i) * math.ceil(i)
    return sum

# 189 
def can_arrange(arr):
    index = - 1
    for i in range(len(arr)):
        if arr[i] <= i:
            index = i
    return index

# 190 
def largest_smallest_integers(lst):
    max_neg, min_pos = 0, 0
    for n in lst:
        if n < 0 and(max_neg == 0 or n > max_neg):
            max_neg = n
        if n > 0 and(min_pos == 0 or n < min_pos):
            min_pos = n
    return[max_neg, min_pos]

# 191 
def fix_spaces(text):
    res = []
    space_len = 0
    for i in range(len(text) + 1):
        if i == len(text) or text[i] != ' ':
            if space_len == 1:
                res.append('_')
            if space_len == 2:
                res.append('__')
            if space_len > 2:
                res.append('-')
            space_len = 0
            if i != len(text):
                res.append(text[i])
        else:
            space_len += 1
    return "".join(res)

# 192 
def file_name_check(file_name):
    digit_num, dot_num = 0, 0
    if len(file_name) < 5 or not file_name[0].isalpha():
        return "No"
    suffix = file_name[- 4:]
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
    result = []
    current = []
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
                result.append("".join(current) + " ")
            current.clear()
        else:
            current.append(sentence[i])
    result = "".join(result)
    if len(result) > 0:
        result = result[: - 1]
    return result

# 195 
def simplify(x, n):
    a, b, c, d = 0, 0, 0, 0
    for i in range(len(x)):
        if x[i] == '/':
            a = int(x[: i])
            b = int(x[i + 1:])
    for i in range(len(n)):
        if n[i] == '/':
            c = int(n[: i])
            d = int(n[i + 1:])
    return(a * c) % (b * d) == 0

# 196 
def specialFilter(nums):
    count = 0
    for num in nums:
        if num > 10:
            w = str(num)
            if ord(w[0]) % 2 == 1 and ord(w[- 1]) % 2 == 1:
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
                if(arr[i] + arr[j] + arr[k]) % 3 == 0:
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
    max = - sys.maxsize
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
    return class_name + "." + strongest

# 201 
def int_to_mini_roman(number):
    num = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    sym = ["m", "cm", "d", "cd", "c", "xc", "l", "xl", "x", "ix", "v", "iv", "i"]
    pos = 0
    res = []
    while number > 0:
        while number >= num[pos]:
            res.append(sym[pos])
            number -= num[pos]
        if number > 0:
            pos += 1
    return "".join(res)

# 202 
def eat(number, need, remaining):
    return[number + remaining, 0] if need > remaining else[number + need, remaining - need]

# 203 
def do_algebra(ops, operands):
    nums = list(operands)
    current_ops = list(ops)
    i = len(current_ops) - 1
    while i >= 0:
        if current_ops[i] == "**":
            nums[i] = pow(nums[i], nums[i + 1])
            nums.pop(i + 1)
            current_ops.pop(i)
        i -= 1
    i = 0
    while i < len(current_ops):
        if current_ops[i] == "*":
            nums[i] *= nums[i + 1]
            nums.pop(i + 1)
            current_ops.pop(i)
        elif current_ops[i] == "//":
            nums[i] //= nums[i + 1]
            nums.pop(i + 1)
            current_ops.pop(i)
        else:
            i += 1
    i = 0
    while i < len(current_ops):
        if current_ops[i] == "+":
            nums[i] += nums[i + 1]
            nums.pop(i + 1)
            current_ops.pop(i)
        elif current_ops[i] == "-":
            nums[i] -= nums[i + 1]
            nums.pop(i + 1)
            current_ops.pop(i)
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
    prev_digit = - 1
    while n > 0:
        cur_digit = n % 10
        if prev_digit == - 1:
            prev_digit = cur_digit
        else:
            if abs(prev_digit - cur_digit) != 1:
                return False
        prev_digit = cur_digit
        n //= 10
    return True

# 206 
def num_of_ways(n, k):
    p = 1
    if k % 2:
        p = - 1
    return((n - 1) ** k + p * (n - 1)) // n

# 207 
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
def egg_drop(n, k):
    if k == 1 or k == 0:
        return k
    if n == 1:
        return k
    min = sys.maxsize
    for x in range(1, k + 1):
        res = max(egg_drop(n - 1, x - 1), egg_drop(n, k - x))
        if res < min:
            min = res
    return min + 1

# 209 
def is_power_of_two(n):
    return math.ceil(math.log2 (n)) == math.floor(math.log2 (n))

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
            ans = min(ans, v[i])
    return ans

# 211 
def minimum_adjacent_difference(a, n, k):
    min_diff = sys.maxsize
    for i in range(k + 1):
        max_diff = - sys.maxsize
        for j in range(n - k - 1):
            for p in range(i, i + j + 1):
                max_diff = max(max_diff, a[p + 1] - a[p])
        min_diff = min(min_diff, max_diff)
    return min_diff

# 212 
def cal(a, mid):
    chocolate = 0
    for i in a:
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
            ans = ans + mov
            tec += mov
            b[i + 2] = mov
    return ans <= m

# 214 
def largest_num(arr):
    res = 0
    arr.sort()
    l, r = 0, len(arr) - 1
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
    index = - 1
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
def min_digits(n, k):
    digits_num = math.floor(math.log10 (n) + 1)
    temp_sum = 0
    temp = digits_num
    result = 0
    x, v = 0, 0
    sum = 0
    num2 = n
    while num2 != 0:
        sum += num2 % 10
        num2 //= 10
    if sum <= k:
        x = 0
    else:
        while temp > 0:
            v = n // (10 ** (temp - 1))
            temp_sum += v % 10
            if temp_sum >= k:
                v //= 10
                v += 1
                result = v * (10 ** temp)
                break
            temp -= 1
        x = result - n
        return x
    return - 1

# 218 
def check_for_perfect_square(arr, i, j):
    mid, sum = 0, 0
    for m in range(i, j + 1):
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
    return - 1

# 219 
def min_flips(mat, s):
    n = len(mat)
    m = len(mat[0])
    count = 0
    for i in range(n):
        for j in range(m):
            if mat[i] [j] != ord(s[i + j]) - ord('0'):
                count += 1
    return count

# 220 
def construct_tree(n, edges):
    adjl = []
    for i in range(n):
        adjl.append([])
    for e in edges:
        u = e[0]
        v = e[1]
        adjl[u].append(v)
        adjl[v].append(u)
    return adjl

# 221 
def find_sum_of_values(v, parent, values_children):
    cur_node = v
    Sum = 0
    while cur_node != - 1:
        Sum += values_children[cur_node]
        cur_node = parent[cur_node]
    return Sum

# 222 
def get_distinct(d, count):
    num = 0
    count = 10 ** (count - 1)
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
def min_adj_swaps(mat):
    n = len(mat)
    cnt_zero = [0] * n
    for i in range(n):
        for j in range(n - 1, - 1, - 1):
            if mat[i] [j] != 0:
                break
            cnt_zero[i] += 1
    cnt_swaps = 0
    for i in range(n):
        if cnt_zero[i] < (n - i - 1):
            first = i
            while first < n and cnt_zero[first] < (n - i - 1):
                first += 1
            if first == n:
                return - 1
            while first > i:
                cnt_zero[first], cnt_zero[first - 1] = cnt_zero[first - 1], cnt_zero[first]
                first -= 1
                cnt_swaps += 1
    return cnt_swaps

# 225 
def solve(values, salary, mod):
    ret = 1
    amt = 0
    values.sort()
    salary.sort()
    while len(salary) > 0:
        while len(values) and values[- 1] >= salary[- 1]:
            amt += 1
            values.pop()
        if amt == 0:
            return 0
        ret *= amt
        amt -= 1
        ret %= mod
        salary.pop()
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
    count = 2 ** n
    return count

# 230 
def prime_power(x):
    prime_pow = []
    for i in range(2, x + 1):
        if i * i > x + 1:
            break
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
def is_perfect(n0):
    n = math.sqrt(n0)
    if math.floor(n) != math.ceil(n):
        return 0
    return 1

# 232 
def find_sum(l, r):
    arr = []
    i = 0
    x = 2
    while i <= r:
        arr.append(i + x)
        if i + 1 <= r:
            arr.append(i + 1 + x)
        x *= - 1
        i += 2
    sum = 0
    for i in range(l, r + 1):
        sum += arr[i]
    return sum

# 233 
def results(n, k):
    return round(n ** (1.0 / 2 ** k))

# 234 
def factors(n):
    v = []
    v.append(1)
    for i in range(2, int(math.sqrt(n)) + 1, 1):
        if n % i == 0:
            v.append(i)
            if n // i != i:
                v.append(n // i)
    return v

# 235 
def smallest_num(n):
    x = 10.0 ** ((n - 1) / 2.0)
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
    return - 1

# 237 
def diagonals(a, b, c, d):
    ans = []
    ans.append(math.sqrt((a * c + b * d) * (a * d + b * c) / (a * b + c * d)))
    ans.append(math.sqrt((a * c + b * d) * (a * b + c * d) / (a * d + b * c)))
    return ans

# 238 
def find_number_of_digits(n, base):
    dig = math.floor(math.log(n) / math.log(base)) + 1
    return dig

# 239 
def n_gon(n):
    pro_angle_var = 0
    if n % 4 == 0:
        pro_angle_var = math.pi * (180.0 / n) / 180
    else:
        pro_angle_var = math.pi * (180.0 / (2 * n)) / 180
    neg_x = 1.0e+99
    pos_x = - 1.0e+99
    neg_y = 1.0e+99
    pos_y = - 1.0e+99
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
def find_max_k(n):
    p = int(math.log2 (n))
    return 2 ** p

# 241 
def nth_fibo(n):
    a = (5 ** 0.5 + 1) / 2
    b = (- 5 ** 0.5 + 1) / 2
    r = 5 ** 0.5
    ans = (a ** n - b ** n) / r
    return int(ans)

# 242 
def find_prob(l, r):
    count_of_ps = math.floor(math.sqrt(r)) - math.ceil(math.sqrt(l)) + 1
    total = r - l + 1
    prob = count_of_ps / total
    return prob

# 243 
def previous_fibonacci(n):
    a = n / ((1 + math.sqrt(5)) / 2.0)
    return round(a)

# 244 
def dist_prime(arr, all_primes):
    list1 = []
    for i in all_primes:
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
    counts = [0] * 11
    ans = 0
    for index in range(len(a)):
        counts[a[index]] += 1
        k = []
        for i in counts:
            if i != 0:
                k.append(i)
        k.sort()
        if len(k) == 1 or(k[0] == k[- 2] and k[- 1] - k[- 2] == 1) or(k[0] == 1 and k[1] == k[- 1]):
            ans = index
    return ans + 1

# 247 
def max_edges(n):
    edges = math.floor(n * n // 4)
    return edges

# 248 
def find_k(n, k):
    a = []
    for i in range(1, n):
        if i % 2 == 1:
            a.append(i)
    for i in range(1, n):
        if i % 2 == 0:
            a.append(i)
    return a[k - 1]

# 249 
def is_keith(x, temp):
    terms = []
    n = 0
    while temp > 0:
        terms.append(temp % 10)
        temp = temp // 10
        n += 1
    terms.reverse()
    next_term, i = 0, n
    while next_term < x:
        next_term = 0
        for j in range(1, n + 1):
            next_term += terms[i - j]
        terms.append(next_term)
        i += 1
    return next_term == x

# 250 
def factors(n, k):
    v = []
    while n % 2 == 0:
        v.append(2)
        n //= 2
    if len(v) >= k:
        return True
    for i in range(3, n + 1, 2):
        if i * i > n:
            break
        while n % i == 0:
            n = n // i
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
        if c == "(":
            current_depth += 1
            current_paren.append(c)
        elif c == ")":
            current_depth -= 1
            current_paren.append(c)
            if current_depth == 0:
                all_parens.append("".join(current_paren))
                current_paren.clear()
    return all_parens

# 252 
def parse_nested_parens(paren_string):
    all_levels = []
    level = 0
    max_level = 0
    for i in range(len(paren_string)):
        chr = paren_string[i]
        if chr == "(":
            level += 1
            if level > max_level:
                max_level = level
        if chr == ")":
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
    running_max = 0
    result = []
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
        if r_str == r_str[:: - 1]:
            n_str = s[0: i]
            n2_str = n_str[:: - 1]
            return s + n2_str
    return s[: - 2] + s[:: - 1]

# 256 
def string_xor(a, b):
    result = []
    for i in range(len(a)):
        if a[i] == b[i]:
            result.append("0")
        else:
            result.append("1")
    return "".join(result)

# 257 
def longest(strings):
    if not strings:
        return ""
    max_len = max(len(x) for x in strings)
    for s in strings:
        if len(s) == max_len:
            return s
    return ""

# 258 
def string_sequence(n):
    s = []
    for i in range(n):
        s.append(str(i))
        s.append(" ")
    s.append(str(n))
    return "".join(s)

# 259 
def count_distinct_characters(s):
    distinct = set()
    for c in s.lower():
        distinct.add(c)
    return len(distinct)

# 260 
def how_many_times(s, sub):
    times = 0
    for i in range(len(s) - len(sub) + 1):
        if s[i: i + len(sub)] == sub:
            times += 1
    return times

# 261 
def sort_numbers(numbers):
    to_num = {"zero": 0, "one": 1, "two": 2, "three": 3, "four": 4, "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}
    from_num = {0: "zero", 1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six", 7: "seven", 8: "eight", 9: "nine"}
    ints = []
    current = []
    for i in range(len(numbers) + 1):
        if i == len(numbers) or numbers[i] == " ":
            if "".join(current) in to_num:
                ints.append(to_num["".join(current)])
                current.clear()
        else:
            current.append(numbers[i])
    ints.sort()
    result = []
    for i in range(len(ints)):
        result.append(from_num[ints[i]])
        if i != len(ints) - 1:
            result.append(" ")
    return "".join(result)

# 262 
def find_closest_elements(numbers):
    closest_pair = [numbers[0], numbers[1]]
    distance = abs(closest_pair[0] - closest_pair[1])
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
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
    counter = {}
    for i in numbers:
        counter[i] = counter.get(i, 0) + 1
    result = []
    for i in numbers:
        if counter[i] == 1:
            result.append(i)
    return result

# 266 
def flip_case(s):
    result = []
    for c in s:
        if c.islower():
            result.append(c.upper())
        else:
            result.append(c.lower())
    return "".join(result)

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
        value += xs[i] * ans ** i
    while abs(value) > 1e-6:
        driv = 0
        for i in range(1, len(xs)):
            driv += xs[i] * ans ** (i - 1) * i
        ans -= value / driv
        value = 0
        for i in range(len(xs)):
            value += xs[i] * ans ** i
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
def triples_sum_to_zero(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            for k in range(j + 1, len(l)):
                if l[i] + l[j] + l[k] == 0:
                    return True
    return False

# 273 
def fib4 (n):
    results = [0, 0, 2, 0]
    for i in range(4, n + 1):
        results.append(results[i - 4] + results[i - 3] + results[i - 2] + results[i - 1])
    return results[n]

# 274 
def is_palindrome(text):
    pr = text[:: - 1]
    return pr == text

# 275 
def remove_vowels(text):
    result = []
    vowels = "aeiou"
    for ch in text:
        if ch.lower() not in vowels:
            result.append(ch)
    return "".join(result)

# 276 
def same_chars(s0, s1):
    set0 = set()
    for c in s0:
        set0.add(c)
    set1 = set()
    for c in s1:
        set1.add(c)
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
def correct_bracketing(brackets):
    depth = 0
    for b in brackets:
        if b == "(":
            depth += 1
        else:
            depth -= 1
        if depth < 0:
            return False
    return depth == 0

# 279 
def circular_shift(x, shift):
    s = str(x)
    if shift > len(s):
        return s[:: - 1]
    return s[- shift:] + s[: - shift]

# 280 
def search(lst):
    counter = {}
    for i in lst:
        counter[i] = counter.get(i, 0) + 1
    ans = - 1
    for key, value in counter.items():
        if value >= key > ans:
            ans = key
    return ans

# 281 
def smallest_change(arr):
    ans = 0
    for i in range(len(arr) // 2):
        if arr[i] != arr[- i - 1]:
            ans += 1
    return ans

# 282 
def total_match(lst1, lst2):
    sum1 = 0
    for st in lst1:
        sum1 += len(st)
    sum2 = 0
    for st in lst2:
        sum2 += len(st)
    return lst2 if sum1 > sum2 else lst1

# 283 
def is_happy(s):
    if len(s) < 3:
        return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i + 1] == s[i + 2] or s[i] == s[i + 2]:
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
    bi_str = []
    sum = 0
    for c in str(n):
        sum += ord(c) - ord("0")
    while sum > 0:
        bi_str.insert(0, str(sum % 2))
        sum //= 2
    return "".join(bi_str)

# 286 
def anti_shuffle(s):
    ret = []
    current = []
    for i in range(len(s) + 1):
        if i == len(s) or s[i] == " ":
            current.sort()
            if ret:
                ret.append(" ")
            ret.append("".join(current))
            current.clear()
        else:
            current.append(s[i])
    return "".join(ret)

# 287 
def sort_array(array):
    if not array:
        return array
    if(array[0] + array[- 1]) % 2 == 1:
        array.sort()
    else:
        array.sort(reverse = True)
    return array

# 288 
def encrypt(s):
    ans = []
    for c in s:
        if c.isalpha():
            ans.append(chr(ord("a") + (ord(c) - ord("a") + 4) % 26))
        else:
            ans.append(c)
    return "".join(ans)

# 289 
def is_bored(s):
    is_start = True
    sum = 0
    for i in range(len(s)):
        if s[i] == "." or s[i] == "?" or s[i] == "!":
            is_start = True
        elif is_start:
            if s[i] == " ":
                continue
            if s[i: i + 2] == "I ":
                sum += 1
            is_start = False
    return sum

# 290 
def encode(message):
    vowels = "aeiouAEIOU"
    ret = []
    for c in message:
        if c.isupper():
            c = c.lower()
            if c in vowels:
                c = chr(ord("a") + (ord(c) - ord("a") + 2) % 26)
        elif c.islower():
            c = c.upper()
            if c in vowels:
                c = chr(ord("A") + (ord(c) - ord("A") + 2) % 26)
        ret.append(c)
    return "".join(ret)

# 291 
def skjkasdkd(lst):
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
        sum += ord(s[i]) - ord("0")
    return sum

# 292 
def check_dict_case(dict):
    if not dict:
        return False
    is_lower = 0
    is_upper = 0
    for key in dict:
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
    return(abs(a) % 10) * (abs(b) % 10)

# 294 
def count_upper(s):
    u_vowel = "AEIOU"
    count = 0
    for i in range(0, len(s), 2):
        if s[i] in u_vowel:
            count += 1
    return count

# 295 
def by_length(arr):
    num_to = {1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"}
    sorted_arr = sorted(arr, reverse = True)
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
    for i in range(1, n + 1):
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
    for i in range(1, n + 1):
        s = str(i)
        r_str = s[:: - 1]
        if s == r_str:
            if i % 2 == 1:
                odd_count += 1
            else:
                even_count += 1
    return[even_count, odd_count]

# 298 
def histogram(test):
    count = {}
    max = 0
    for i in range(len(test)):
        if test[i] != " ":
            count[test[i]] = count.get(test[i], 0) + 1
            if count[test[i]] > max:
                max = count[test[i]]
    result = {}
    for key, value in count.items():
        if value == max:
            result[key] = value
    return result

# 299 
def reverse_delete(s, c):
    ret = []
    for ch in s:
        if ch not in c:
            ret.append(ch)
    flag = "False"
    if "".join(ret) == "".join(ret[:: - 1]):
        flag = "True"
    return["".join(ret), flag]

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
            if bin[j] < bin[j - 1] or(bin[j] == bin[j - 1] and arr[j] < arr[j - 1]):
                bin[j], bin[j - 1] = bin[j - 1], bin[j]
                arr[j], arr[j - 1] = arr[j - 1], arr[j]
    return arr

# 301 
def get_closest_vowel(word):
    vowels = "AEIOUaeiou"
    for i in range(len(word) - 2, 0, - 1):
        if word[i] in vowels and word[i + 1] not in vowels and word[i - 1] not in vowels:
            return word[i]
    return ""

# 302 
def match_parens(lst):
    strings = [lst[0] + lst[1], lst[1] + lst[0]]
    for l in strings:
        count = 0
        for c in l:
            if c == "(":
                count += 1
            if c == ")":
                count -= 1
            if count < 0:
                break
        if count == 0:
            return "Yes"
    return "No"

# 303 
def maximum(arr, k):
    if k == 0:
        return[]
    arr.sort()
    return arr[- k:]

# 304 
def valid_date(date):
    if len(date) != 10:
        return False
    for i in range(10):
        if i == 2 or i == 5:
            if date[i] != "-":
                return False
        elif not date[i].isdigit():
            return False
    month = int(date[0: 2])
    day = int(date[3: 5])
    year = int(date[6: 10])
    if month < 1 or month > 12:
        return False
    if day < 1 or day > 31:
        return False
    if day == 31 and(month == 4 or month == 6 or month == 9 or month == 11 or month == 2):
        return False
    if day == 30 and month == 2:
        return False
    return True

# 305 
def split_words(txt):
    current = []
    result = []
    if " " in txt:
        for i in range(len(txt) + 1):
            if i == len(txt) or txt[i] == " ":
                if len(current) > 0:
                    result.append("".join(current))
                    current.clear()
            else:
                current.append(txt[i])
        return result
    if "," in txt:
        for i in range(len(txt) + 1):
            if i == len(txt) or txt[i] == ",":
                if len(current) > 0:
                    result.append("".join(current))
                    current.clear()
            else:
                current.append(txt[i])
        return result
    num = 0
    for c in txt:
        if c.islower() and ord(c) % 2 == 0:
            num += 1
    return[str(num)]

# 306 
def tri(n):
    if n == 0:
        return[1]
    tris = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            tris.append(i // 2 + 1)
        else:
            tris.append(tris[i - 1] + tris[i - 2] + (i + 3) // 2)
    return tris

# 307 
def check_if_last_char_is_a_letter(txt):
    if not txt:
        return False
    return txt[- 1].isalpha() and(len(txt) == 1 or not txt[- 2].isalpha())

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
        for j in range(1, len(nums)):
            if result[j - 1] > result[j]:
                result[j], result[j - 1] = result[j - 1], result[j]
                nums[j], nums[j - 1] = nums[j - 1], nums[j]
    return nums

# 309 
def bf(planet1, planet2):
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    idx1 = planets.index(planet1) if planet1 in planets else - 1
    idx2 = planets.index(planet2) if planet2 in planets else - 1
    if idx1 == - 1 or idx2 == - 1 or idx1 == idx2:
        return[]
    return planets[idx2 + 1: idx1] if idx1 > idx2 else planets[idx1 + 1: idx2]

# 310 
def sorted_list_sum(lst):
    result = []
    for i in lst:
        if len(i) % 2 == 0:
            result.append(i)
    result.sort(key = lambda s: (len(s), s))
    return result

# 311 
def cycpattern_check(a, b):
    for i in range(len(b)):
        rotate = b[i:] + b[0: i]
        if rotate in a:
            return True
    return False

# 312 
def even_odd_count(num):
    even_count, odd_count = 0, 0
    for i in str(abs(num)):
        if int(i) % 2 == 0:
            even_count += 1
        else:
            odd_count += 1
    return[even_count, odd_count]

# 313 
def find_max(words):
    max = ""
    max_length = 0
    for word in words:
        unique = []
        for w in word:
            if w not in unique:
                unique.append(w)
            if len(unique) > max_length or(len(unique) == max_length and word < max):
                max = word
                max_length = len(unique)
    return max

# 314 
def solve(s):
    no_letter = True
    result = []
    for ch in s:
        if ch.isupper():
            ch = ch.lower()
            no_letter = False
        elif ch.islower():
            ch = ch.upper()
            no_letter = False
        result.append(ch)
    if no_letter:
        return "".join(result) [:: - 1]
    else:
        return "".join(result)

# 315 
def most_frequent(arr, n):
    hp = {}
    for i in range(n):
        if arr[i] in hp:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
    max_count, res = 0, - 1
    for key, value in hp.items():
        if max_count < value:
            res = key
            max_count = value
    return res

# 316 
def find(a, b, k, n1, n2):
    s = set()
    for i in range(n2):
        s.add(b[i])
    missing = 0
    for i in range(n1):
        if a[i] not in s:
            missing += 1
        if missing == k:
            return a[i]
    return - 1

# 317 
def solve_query(start, end, arr):
    frequency = dict()
    for i in range(start, end + 1):
        frequency[arr[i]] = frequency.get(arr[i], 0) + 1
    count = 0
    for key, value in frequency.items():
        if key == value:
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
    for i in range(n):
        s.add(a[i])
    count = 0
    for i in range(n):
        for j in range(i + 1, n, 1):
            xr = a[i] ^ a[j]
            if xr in s and xr != a[i] and xr != a[j]:
                count += 1
    return int(count / 3)

# 320 
def least_frequent(arr, n):
    hp = {}
    for i in range(n):
        if arr[i] in hp:
            hp[arr[i]] += 1
        else:
            hp[arr[i]] = 1
    min_count = n + 1
    res = - 1
    for key, value in hp.items():
        if min_count >= value:
            res = key
            min_count = value
    return res

# 321 
def find_permutations(arr):
    cnt = 0
    max_ind, min_ind = - 1, 10000000
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
def form_quadruplets(arr, n):
    ans, pairs = 0, 0
    pairs = n // 4
    arr.sort(reverse = True)
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
    for i in range(ord("a"), ord("a") + min(n, 25)):
        if chr(i) not in m:
            v.append(chr(i))
    j = len(v) - 1
    for i in range(n):
        if ord(s[i]) >= ord("a") + min(n, 25) or(s[i] in m and m[s[i]] > 1):
            if ord(v[j]) < ord(s[i]):
                continue
            m[s[i]] -= 1
            s = s[0: i] + v[j] + s[i + 1:]
            j -= 1
        if j < 0:
            break
    l = 0
    for i in range(n - 1, - 1, - 1):
        if l > j:
            break
        if ord(s[i]) >= ord("a") + min(n, 25) or s[i] in m and m[s[i]] > 1:
            m[s[i]] -= 1
            s = s[0: i] + v[l] + s[i + 1:]
            l += 1
    return s

# 324 
def no_of_valid_kbers(k, arr):
    st = set()
    while k != 0:
        st.add(k % 10)
        k = k // 10
    count = 0
    for i in range(len(arr)):
        no = arr[i]
        flag = True
        while no != 0:
            digit = no % 10
            if digit not in st:
                flag = False
                break
            no = no // 10
        if flag == True:
            count += 1
    return count

# 325 
def del_cost(s, cost):
    ans = 0
    for_max = {}
    for_tot = {}
    for i in range(len(s)):
        if s[i] not in for_max:
            for_max[s[i]] = cost[i]
        else:
            for_max[s[i]] = max(cost[i], for_max[s[i]])
        if s[i] not in for_tot:
            for_tot[s[i]] = cost[i]
        else:
            for_tot[s[i]] += cost[i]
    for key, value in for_max.items():
        ans += for_tot[key] - value
    return ans

# 326 
def replace_duplicates(names):
    hash = {}
    for i in range(len(names)):
        if names[i] not in hash:
            hash[names[i]] = 1
        else:
            count = hash[names[i]]
            hash[names[i]] += 1
            names[i] += str(count)
    return names

# 327 
def minmax_numbers(matrix, res):
    s = set()
    for i in range(len(matrix)):
        min_r = sys.maxsize
        for j in range(len(matrix[i])):
            min_r = min(min_r, matrix[i] [j])
        s.add(min_r)
    for j in range(len(matrix[0])):
        max_c = - sys.maxsize
        for i in range(len(matrix)):
            max_c = max(max_c, matrix[i] [j])
        if max_c in s:
            res.append(max_c)
    return res

# 328 
def length_of_longest_ap(a, n):
    dp = {}
    res = 2
    for i in range(n):
        for j in range(i + 1, n):
            d = a[j] - a[i]
            if d in dp:
                if i in dp[d]:
                    dp[d] [j] = dp[d] [i] + 1
                else:
                    dp[d] [j] = 2
            else:
                dp[d] = {}
                dp[d] [j] = 2
            res = max(res, dp[d] [j])
    return res

# 329 
def find_kth_char(n, k):
    prev = "A"
    cur = ""
    if n == 1:
        return "A"
    for i in range(2, n + 1):
        cur = prev + "B"
        for i in range(len(prev)):
            if prev[i] == "A":
                prev = prev[0: i] + "B" + prev[i + 1:]
            else:
                prev = prev[0: i] + "A" + prev[i + 1:]
        prev = prev[:: - 1]
        cur += prev
        prev = cur
    return cur[k - 1]

# 330 
def find_kth_largest(s, k):
    tmp = list(s)
    tmp.sort(reverse = True)
    return tmp[k - 1]

# 331 
def sub_arraylen(arr, n, k):
    mp = {}
    mp[arr[0]] = 0
    for i in range(1, n):
        arr[i] = arr[i] + arr[i - 1]
        mp[arr[i]] = i
    len = sys.maxsize
    for i in range(n):
        if arr[i] < k:
            continue
        else:
            x = arr[i] - k
            if x == 0:
                len = min(len, i)
            if x not in mp:
                continue
            else:
                len = min(len, i - mp.get(x, 0))
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
            if check in mp:
                c += 1
                vis[mp[check]] = True
    return n - c

# 333 
def min_distance_points(a, k, n):
    m = {}
    q = []
    for i in range(n):
        m[a[i]] = 1
        q.append(a[i])
    ans = []
    while k > 0:
        x = q[0]
        q = q[1::]
        if(x - 1) not in m and k > 0:
            m[x - 1] = 1
            q.append(x - 1)
            ans.append(x - 1)
            k -= 1
        if(x + 1) not in m and k > 0:
            m[x + 1] = 1
            q.append(x + 1)
            ans.append(x + 1)
            k -= 1
    return ans

# 334 
def isValidLen(s, length, k):
    n = len(s)
    mp = dict()
    right = 0
    while right < length:
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
        mp[s[right - length]] -= 1
        if mp[s[right - length]] == 0:
            del mp[s[right - length]]
        if len(mp) <= k:
            return True
        right += 1
    return len(mp) <= k

# 335 
def partition(arr, low, high):
    pivot = arr[high]
    i = (low - 1)
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
    if s not in m.keys():
        return 0
    score = 0
    for i in range(len(s)):
        score += ord(s[i]) - ord("a") + 1
    score = score * m[s]
    return score

# 337 
def count_ele(s, a, n):
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
                s.pop(0)
                cnt += 1
            s.pop(0)
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
        v[i] = v[i] - mn
        k -= mn
    if k > 0:
        for i in range(len(v)):
            mn = min(v[i], k)
            v[i] = v[i] - mn
            k -= mn
    res = 0
    for i in range(len(v)):
        if v[i] == 1:
            res += 1
    return res

# 339 
def find_kth(arr, n, k):
    missing = {}
    count = 0
    for i in range(n):
        missing[arr[i]] = 1
    max_m = max(arr)
    min_m = min(arr)
    for i in range(min_m + 1, max_m):
        if i not in missing:
            count += 1
        if count == k:
            return i
    return - 1

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
def maximum_sum(s, n, k):
    sum = 0
    freq = [0] * 256
    for i in range(n):
        freq[ord(s[i])] += 1
    freq.sort(reverse = True)
    for i in range(256):
        if k > freq[i]:
            sum += freq[i] * freq[i]
            k -= freq[i]
        else:
            sum += freq[i] * k
            break
    return sum

# 342 
def find_min_operations(arr, n, k):
    operations = 0
    for i in range(k):
        freq = {}
        for j in range(i, n, k):
            freq[arr[j]] = freq.get(arr[j], 0) + 1
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
        for len in range(1, n - i + 1):
            find = s[i: i + len]
            v.append(find)
    return v

# 344 
def check_unique_frequency(arr, n):
    freq = {}
    for i in range(n):
        freq[arr[i]] = freq.get(arr[i], 0) + 1
    unique_freq = set()
    for i in freq:
        if freq[i] in unique_freq:
            return False
        else:
            unique_freq.add(freq[i])
    return True

# 345 
def min_cost(str1, str2, n):
    cost = 0
    tmp = list(str1)
    for i in range(n):
        if tmp[i] != str2 [i]:
            if i < n - 1 and tmp[i + 1] != str2 [i + 1]:
                tmp[i], tmp[i + 1] = tmp[i + 1], tmp[i]
                cost += 1
            else:
                cost += 1
    return cost

# 346 
def is_valid_num(x):
    mp = dict()
    for i in range(len(x)):
        if ord(x[i]) - ord("0") in mp:
            return False
        elif ord(x[i]) - ord("0") > 5:
            return False
        else:
            mp[ord(x[i]) - ord("0")] = 1
    return True

# 347 
def minimize_diff(arr, n, k):
    max_element = max(arr)
    min_element = min(arr)
    if max_element - min_element <= k:
        return max_element - min_element
    avg = (max_element + min_element) // 2
    for i in range(n):
        if arr[i] > avg:
            arr[i] -= k
        else:
            arr[i] += k
    max_element = max(arr)
    min_element = min(arr)
    return max_element - min_element

# 348 
def get_min_cost(arr, n):
    min_ele = min(arr)
    return min_ele * (n - 1)

# 349 
def possibility(m, length, s):
    count_odd = 0
    for i in range(length):
        if m[ord(s[i]) - ord('0')] & 1:
            count_odd += 1
        if count_odd > 1:
            return False
    return True

# 350 
def minimum_cost_of_breaking(x, y, m, n):
    res = 0
    x.sort(reverse = True)
    y.sort(reverse = True)
    hzntl, vert = 1, 1
    i, j = 0, 0
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
        dp[i] = max(dp[i - 1], dp[i - 2] + freq.get(i, 0) * i)
    return dp[- 1]

# 352 
def count_ways(s, t, k, mod):
    n = len(s)
    a = 0
    b = 0
    for i in range(n):
        p = s[i: n] + s[: i]
        if p == t:
            a += 1
        else:
            b += 1
    dp1 = [0] * (k + 1)
    dp2 = [0] * (k + 1)
    if s == t:
        dp1 [0] = 1
        dp2 [0] = 0
    else:
        dp1 [0] = 0
        dp2 [0] = 1
    for i in range(1, k + 1):
        dp1 [i] = ((dp1 [i - 1] * (a - 1)) % mod + (dp2 [i - 1] * a) % mod) % mod
        dp2 [i] = ((dp1 [i - 1] * b) % mod + (dp2 [i - 1] * (b - 1)) % mod) % mod
    return dp1 [k]

# 353 
def find_subarray_sum(arr, n, k):
    prev_sum = {}
    res = 0
    curr_sum = 0
    for i in range(n):
        curr_sum += arr[i]
        if curr_sum == k:
            res += 1
        if(curr_sum - k) in prev_sum:
            res += prev_sum[curr_sum - k]
        prev_sum[curr_sum] = prev_sum.get(curr_sum, 0) + 1
    return res

# 354 
def maximum_occurrence(s):
    n = len(s)
    freq = {}
    for i in range(len(s)):
        temp = ""
        temp += s[i]
        freq[temp] = freq.get(temp, 0) + 1
    for i in range(n):
        for j in range(i + 1, n):
            temp = ""
            temp += s[i]
            temp += s[j]
            freq[temp] = freq.get(temp, 0) + 1
    answer = - sys.maxsize
    for key, value in freq.items():
        answer = max(answer, value)
    return answer

# 355 
def count_characters(strings, chars):
    res = 0
    freq = {}
    for i in range(len(chars)):
        freq[chars[i]] = freq.get(chars[i], 0) + 1
    for st in strings:
        flag = True
        for c in list(st):
            if c not in freq:
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
        for j in range(i, n):
            pos = ord(p[j]) - ord('a')
            sum += ord(q[pos]) - ord('0')
            s += p[j]
            if sum <= k:
                ss.add(s)
            else:
                break
    return len(ss)

# 357 
def unique_morse_rep(arr):
    morse_code = [".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."]
    st = set()
    n = len(arr)
    for i in range(n):
        temp = ""
        m = len(arr[i])
        for j in range(m):
            temp += morse_code[ord(arr[i] [j]) - ord("a")]
        st.add(temp)
    return len(st)

# 358 
def count_substrings(str, k):
    n = len(str)
    answer = 0
    map = {}
    for i in range(k):
        if str[i] not in map:
            map[str[i]] = 1
        else:
            map[str[i]] += 1
    if len(map) == k:
        answer += 1
    for i in range(k, n):
        if str[i] not in map:
            map[str[i]] = 1
        else:
            map[str[i]] += 1
        map[str[i - k]] -= 1
        if map[str[i - k]] == 0:
            del map[str[i - k]]
        if len(map) == k:
            answer += 1
    return answer

# 359 
def can_construct(s, k):
    m = dict()
    p = 0
    if len(s) == k:
        return True
    for i in range(len(s)):
        m[s[i]] = m.get(s[i], 0) + 1
    if k > len(s):
        return False
    else:
        for key, value in m.items():
            if value % 2 != 0:
                p = p + 1
    if k < p:
        return False
    return True

# 360 
def equal_ignore_case(str1, str2):
    str1 = str1.upper()
    str2 = str2.upper()
    return str1 == str2

# 361 
def find_longest_sub(bin):
    n = len(bin)
    sum = 0
    prev_sum = {}
    max_len = 0
    for i in range(n):
        if bin[i] == "1":
            sum += 1
        else:
            sum -= 1
        if sum > 0:
            max_len = i + 1
        elif sum <= 0:
            if(sum - 1) in prev_sum:
                curr_len = i - prev_sum[sum - 1]
                max_len = max(max_len, curr_len)
        if sum not in prev_sum:
            prev_sum[sum] = i
    return max_len

# 362 
def has_all_codes(s, k):
    us = set()
    for i in range(len(s) + 1):
        us.add(s[i: k])
    return len(us) == 1 << k

# 363 
def check_palin(word):
    n = len(word)
    word = word.lower()
    for i in range(n):
        if word[i] != word[n - 1]:
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
        if ch != " ":
            w += ch
        else:
            z += w[0].lower() + w[1: len(w)] + " "
            w = ""
    return z

# 365 
def max_lines(n, x1, y1, x2, y2):
    s = set()
    slope = 0
    for i in range(n):
        if x1 [i] == x2 [i]:
            slope = sys.maxsize
        else:
            slope = (y2 [i] - y1 [i]) * 1.0 / (x2 [i] - x1 [i])
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
        n = n // 2
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        while n % i == 0:
            if i in primef:
                primef[i] += 1
            else:
                primef[i] = 1
            n = n // i
    if n > 2:
        primef[n] = 1
    return primef

# 367 
def is_divisible_by_divisor(s, d):
    s %= d
    hash_map = set()
    hash_map.add(s)
    for i in range(d + 1):
        s += s % d
        s %= d
        if s in hash_map:
            if s == 0:
                return "Yes"
            return "No"
        else:
            hash_map.add(s)
    return "Yes"

# 368 
def odd_sum(a, n, k):
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
    year = int(date[0: 4])
    month = int(date[5: 7])
    day = int(date[8:])
    if month > 2 and year % 4 == 0 and(year % 100 != 0 or year % 400 == 0):
        day += 1
    while month > 1:
        day = day + days[month - 2]
        month -= 1
    return day

# 370 
def is_perfect_square(arr, n):
    umap = {}
    for i in range(n):
        umap[arr[i]] = umap.get(arr[i], 0) + 1
    for key, value in umap.items():
        if value % 2 == 1:
            return False
    return True

# 371 
def min_moves(n):
    s = str(n)
    ans = sys.maxsize
    length = len(s)
    for i in range(length):
        for j in range(length):
            if i == j:
                continue
            t = list(s)
            cur = 0
            for k in range(i, length - 1):
                t[k], t[k + 1] = t[k + 1], t[k]
                cur += 1
            for k in range(j - (j > i), length - 2):
                t[k], t[k + 1] = t[k + 1], t[k]
                cur += 1
            pos = - 1
            for k in range(length):
                if t[k] != "0":
                    pos = k
                    break
            for k in range(pos, 0, - 1):
                t[k], t[k - 1] = t[k - 1], t[k]
                cur += 1
            nn = int("".join(t))
            if nn % 25 == 0:
                ans = min(ans, cur)
    if ans == sys.maxsize:
        return - 1
    return ans

# 372 
def minimum_operations(a, n):
    mp = {}
    for i in range(n):
        mp[a[i]] = mp.get(a[i], 0) + 1
    count = 0
    for key, value in mp.items():
        if value > 1:
            count += value - 1
    return count

# 373 
def kaprekar_rec(n, prev):
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
    digits.sort()
    desc = 0
    for i in range(3, - 1, - 1):
        desc = desc * 10 + digits[i]
    diff = abs(asc - desc)
    if diff == prev:
        return diff
    return kaprekar_rec(diff, prev)

# 374 
def fraction_to_decimal(numr, denr):
    res = ""
    mp = {}
    rem = numr % denr
    while rem != 0 and rem not in mp:
        mp[rem] = len(res)
        rem = rem * 10
        res_part = rem // denr
        res += str(res_part)
        rem = rem % denr
    if rem == 0:
        return ""
    if rem in mp:
        return res[mp[rem]:]
    return ""

# 375 
def is_fancy(num):
    fp = {}
    fp["0"] = "0"
    fp["1"] = "1"
    fp["6"] = "9"
    fp["8"] = "8"
    fp["9"] = "6"
    n = len(num)
    l, r = 0, n - 1
    while l <= r:
        if num[l] not in fp or fp[num[l]] != num[r]:
            return False
        l += 1
        r -= 1
    return True

# 376 
def distinct_odd_ratio(numbers):
    distinct_count = len(set(numbers))
    distinct_odd_count = len([n for n in set(numbers) if n % 2 == 1])
    return distinct_odd_count / distinct_count

# 377 
def compare_sum(numbers, words):
    int_sum = sum(numbers)
    word_length_sum = sum([len(word) for word in words])
    if int_sum < word_length_sum:
        return - 1
    elif int_sum > word_length_sum:
        return 1
    else:
        return 0

# 378 
def all_longer_than(short_words, long_words):
    max_of_short = max([len(w) for w in short_words])
    min_of_long = min([len(w) for w in long_words])
    return min_of_long > max_of_short

# 379 
def compare_odd_even_range(numbers):
    range_odd = max([n for n in numbers if n % 2 == 1]) - min([n for n in numbers if n % 2 == 1])
    range_even = max([n for n in numbers if n % 2 == 0]) - min([n for n in numbers if n % 2 == 0])
    if range_odd < range_even:
        return - 1
    if range_odd > range_even:
        return 1
    return 0

# 380 
def average_distinct_length(words):
    distinct_words = set(words)
    average_len = sum([len(w) for w in distinct_words]) / len(distinct_words) if distinct_words else 0
    return average_len

# 381 
def withdraw_balance(start, withdrawals):
    end = functools.reduce(lambda balance, nextWithdrawal: balance - nextWithdrawal if nextWithdrawal <= balance else balance, withdrawals, start)
    return end

# 382 
def first_short_and_starts_with_o(words):
    matched_element = next(iter([w for w in[w1 for w1 in words if len(w1) < 5] if w.startswith('o')]), "")
    return matched_element

# 383 
def big_number_at_index(numbers, index):
    target_num = [n for n in numbers if n > 5] [index]
    return target_num

# 384 
def contains_square_in_range(range_start, range_length):
    contains_square = any([int(math.sqrt(n)) ** 2 == n for n in range(range_start, range_start + range_length)])
    return contains_square

# 385 
def group_numbers_by_mod(numbers, mod):
    number_groups = {}
    for k, g in itertools.groupby(numbers, lambda n: n % mod):
        number_groups[k] = number_groups.get(k, []) + list(g)
    return number_groups

# 386 
def group_words_by_first_char(words):
    word_groups = {}
    for k, g in itertools.groupby(words, lambda w: w[0]):
        word_groups[k] = word_groups.get(k, []) + list(g)
    return word_groups

# 387 
def order_by_length_and_descending(words):
    sorted_words = sorted(sorted(words, key = lambda w: w, reverse = True), key = lambda w: len(w))
    return sorted_words

# 388 
def order_first_char_descending_reverse(words):
    sorted_words = sorted(words, key = lambda w: (- ord(w[0]), w), reverse = True)
    return sorted_words

# 389 
def get_sublist_of_negative(numbers, start, length):
    sub_list = [n for n in numbers[start:] if n < 0] [: length]
    return sub_list

# 390 
def get_positive_sequence(numbers):
    sub_sequence = list(itertools.takewhile(lambda n: n > 0, itertools.dropwhile(lambda n: n <= 0, numbers)))
    return sub_sequence

# 391 
def get_larger_than_index_sequence(numbers):
    sub_sequence = [x[1] for x in itertools.takewhile(lambda x: x[1] >= x[0], itertools.dropwhile(lambda x: x[1] < x[0], enumerate(numbers)))]
    return sub_sequence

# 392 
def rearrange_word_by_indexes(words, indexes):
    new_indexes = [n % len(words) for n in indexes if n >= len(words)]
    new_words = [words[n] for n in new_indexes]
    return new_words

# 393 
def get_words_upper_lower(words):
    upper_lower_words = [[w.upper(), w.lower()] for w in words]
    return upper_lower_words

# 394 
def select_if_in_place(numbers):
    nums_in_place = [num == index for index, num in enumerate(numbers)]
    return nums_in_place

# 395 
def select_pairs(numbers_a, numbers_b):
    pairs = [[a, b] for a in numbers_a for b in numbers_b if a < b]
    return pairs

# 396 
def string_cross_join(end_words, begin_words):
    cross_strings = [e + ' ' + b for b in begin_words for e in end_words if b[0] == e[- 1]]
    return cross_strings

# 397 
def elements_contain_subword(words, subword):
    if all(subword in w for w in words[: 5]):
        return 1
    elif any(subword in w for w in words[: 5]):
        return 0
    else:
        return - 1

# 398 
def concat_large_numbers(numbers_a, numbers_b, flag):
    all_numbers = [n for n in numbers_a if n > flag] + [n for n in numbers_b if n > flag]
    return all_numbers

# 399 
def dot_product(vector_a, vector_b):
    dot_product = sum([a * b for a, b in zip(vector_a, vector_b)])
    return dot_product

# 400 
def set_difference(set_a, set_b):
    difference = sorted(list(set(set_a).symmetric_difference(set(set_b))))
    return difference

