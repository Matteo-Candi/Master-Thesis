# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s):
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
    ret = are_equivalent(testfunc("aacecaaa"),"a")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("bcbe"),"b")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("bbbbc"),"b")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("abcd"),"a")
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("zffzdc"),"c")
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
