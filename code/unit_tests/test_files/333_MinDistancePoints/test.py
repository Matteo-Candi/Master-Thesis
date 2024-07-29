# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(a, k, n):
    m = {}
    q = []
    for i in range(n):
        m[a[i]] = 1
        q.append(a[i])
    ans = []
    while k > 0:
        x = q.pop(0)
        if (x-1 not in m) and (k > 0):
            m[x-1] = 1
            q.append(x-1)
            ans.append(x-1)
            k -= 1
        if (x+1 not in m) and (k > 0):
            m[x+1] = 1
            q.append(x+1)
            ans.append(x+1)
            k -= 1
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
    ret = are_equivalent(testfunc([1,2,3,4,5],0,5),[])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,3,4,5,7],10,5),[0,2,6,8,-1,9,-2,10,-3,11])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,3,4,5,7],4,5),[0,2,6,8])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,2,3,4,5],5,5),[0,6,-1,7,-2])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([12,14,31],2,3),[11,13])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
