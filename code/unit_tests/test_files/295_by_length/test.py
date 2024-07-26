# Write the declarations here
from collections import *
from typing import *
import itertools
import functools
import math
import sys

# Write the target function here
def testfunc(arr):
    num_to_str = {1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"}
    sorted_arr = sorted(arr, reverse=True)
    new_arr = []
    for n in sorted_arr:
        if 1 <= n <= 9:
            new_arr.append(num_to_str[n])
    return new_arr
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
    ret = are_equivalent(testfunc([2,1,1,4,5,8,2,3]),["Eight","Five","Four","Three","Two","Two","One","One"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([]),[])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,-1,55]),["One"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([1,-1,3,2]),["Three","Two","One"])
    count += 1 if ret else 0
    total += 1
    ret = are_equivalent(testfunc([9,4,8]),["Nine","Eight","Four"])
    count += 1 if ret else 0
    # End here
    if count == total:
        print("All Passed!")
    else:
        print("Compilation Passed!")


if __name__ == "__main__":
    start()
