# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(s, cost):
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
    for i in forMax:
        ans += forTot[i] - forMax[i]
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
    ret = are_equivalent(testfunc("abc",[1,2,3]),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("aabb",[1,2,2,1]),2)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("aabbc",[3,1,1,2,5]),2)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("aaa",[1,2,3]),3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc("abb",[1,4,6]),4)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
