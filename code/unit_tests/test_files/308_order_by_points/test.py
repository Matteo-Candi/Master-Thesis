# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(nums):
    result = []
    for num in nums:
        w = str(abs(num))
        sum = 0
        for c in w:
            sum += int(c)
        if num < 0:
            sum -= 2 * int(w[0])
        result.append(sum)
    for i in range(len(nums)):
        for j in range(1, len(nums)):
            if result[j - 1] > result[j]:
                result[j - 1], result[j] = result[j], result[j - 1]
                nums[j - 1], nums[j] = nums[j], nums[j - 1]
    return nums

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
    ret = are_equivalent(testfunc([1,11,-1,-11,-12]),[-1,-11,1,-12,11])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1234,423,463,145,2,423,423,53,6,37,3457,3,56,0,46]),[0,2,3,6,53,423,423,423,1234,145,37,46,56,463,3457])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([]),[])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,-11,-32,43,54,-98,2,-3]),[-3,-32,-98,-11,1,2,43,54])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([0,6,6,-76,-21,23,4]),[-76,-21,0,4,23,6,6])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
