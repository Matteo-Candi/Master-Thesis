# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(n):
    s = str(n)
    ans = float('inf')
    length = len(s)
    
    for i in range(length):
        for j in range(length):
            if i == j:
                continue
            t = list(s)
            cur = 0
            
            for k in range(i, length-1):
                c = t[k]
                t[k] = t[k+1]
                t[k+1] = c
                cur += 1
                
            for k in range(j-(j>i)-1, length-2):
                c = t[k]
                t[k] = t[k+1]
                t[k+1] = c
                cur += 1
                
            pos = -1
            for k in range(length):
                if t[k] != '0':
                    pos = k
                    break
                
            for k in range(pos, 0, -1):
                c = t[k]
                t[k] = t[k-1]
                t[k-1] = c
                cur += 1
                
            nn = int(''.join(t))
            
            if nn % 25 == 0:
                ans = min(ans, cur)
                
    if ans == float('inf'):
        return -1
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
    ret = are_equivalent(testfunc(123),-1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(573),3)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(500),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(3025),0)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(45806),3)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
