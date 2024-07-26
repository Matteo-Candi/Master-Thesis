# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s, n):
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
# End here


def serialize_list(obj) -> str:
    list_str = ["["]
    for item in obj:
        list_str.append(serialize_obj(item))
        list_str.append(",")
    list_str[-1] = "]"
    return "".join(list_str)


def serialize_dict(obj) -> str:
    m = OrderedDict(sorted(obj.items()))
    dict_str = ["{"]
    for key, value in m.items():
        dict_str.append(serialize_obj(key))
        dict_str.append(":")
        dict_str.append(serialize_obj(value))
        dict_str.append(",")
    dict_str[-1] = "}"
    return "".join(dict_str)


def serialize_obj(obj) -> str:
    if obj is None:
        return "null"
    if isinstance(obj, int) or isinstance(obj, float):
        return "{0:.6f}".format(obj)
    if isinstance(obj, str):
        return '"' + obj + '"'
    if isinstance(obj, bool):
        return str(obj)
    if isinstance(obj, list):
        return serialize_list(obj)
    if isinstance(obj, dict):
        return serialize_dict(obj)
    raise Exception("Unrecognized Type!")


def are_equivalent(o1, o2) -> bool:
    print(serialize_obj(o1)+" "+serialize_obj(o2))
    return serialize_obj(o1) == serialize_obj(o2)


def start():
    ret = False
    count = 0
    total = 0
    # Write the unit tests here
    total += 1
    ret = are_equivalent(testfunc("abfgwdxtv",9),"abfgidhec")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("fghhjy",6),"fedcba")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("qwer",4),"dcba")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("zxcv",4),"dbca")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("abytxlopv",9),"abihgfedc")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
