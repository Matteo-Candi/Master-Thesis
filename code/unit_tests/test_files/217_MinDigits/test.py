# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
import math

def testfunc(n, k):
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
                v = v // 10 + 1
                result = v * 10**temp
                break
            temp -= 1
        x = result - n
    return x

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
    ret = are_equivalent(testfunc(12345,10),55)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(987654,50),-1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(111,5),-1)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(11111,4),89)
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc(4444,10),56)
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
