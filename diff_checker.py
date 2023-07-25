import json

def list_diff_checker(a, b, root_path="root"):
    a_unique = []
    b_unique = []
    diff = []

    for i in range(max(len(a), len(b))):
        if i < len(a) and i < len(b):
            if a[i] == b[i]:
                continue
            elif type(a[i]) != type(b[i]):
                diff.append((f"{root_path}[{i}]", a[i], b[i]))
            elif type(a[i]) == dict:
                a_unique1, b_unique1, diff1 = dict_diff_checker(a[i], b[i], f"{root_path}[{i}]")
                a_unique.extend(a_unique1)
                b_unique.extend(b_unique1)
                diff.extend(diff1)
            else:
                raise NotImplementedError()
    
    return a_unique, b_unique, diff

def dict_diff_checker(a_root, b_root, root_path="root"):
    combined_keys = lambda x, y: set(x.keys()).union(set(y.keys()))
    stack = [(root_path, a_root, b_root, key) for key in combined_keys(a_root, b_root)]
    a_unique = []
    b_unique = []
    diff = []

    while len(stack) > 0:
        path, a, b, key = stack.pop()

        if key not in a:
            b_unique.append((f"{path}['{key}']", b[key]))
        elif key not in b:
            a_unique.append((f"{path}['{key}']", a[key]))
        elif type(a[key]) != type(b[key]):
            diff.append((f"{path}['{key}']", a[key], b[key]))
        elif type(a[key]) == dict and a[key] != b[key]:
            new_nodes = [(f"{path}['{key}']", a[key], b[key], k) for k in combined_keys(a[key], b[key])]
            stack.extend(new_nodes)
        elif type(a[key]) == list and a[key] != b[key]:
            a_unique1, b_unique1, diff1 = list_diff_checker(a[key], b[key], f"{path}['{key}']")
            a_unique.extend(a_unique1)
            b_unique.extend(b_unique1)
            diff.extend(diff1)
        elif a[key] != b[key]:
            diff.append((f"{path}['{key}']", a[key], b[key]))
    
    return a_unique, b_unique, diff

with open("content1.json", "r") as f1:
    with open("content2.json", "r") as f2:
        a_root = json.load(f1)
        b_root = json.load(f2)
        a_unique, b_unique, diff = dict_diff_checker(a_root, b_root)

        if len(a_unique) > 0:
            print("The following is unique to content1.json:")
            for path, val in a_unique:
                print(f"{path}:", val)
            print()

        if len(b_unique) > 0:
            print("The following is unique to content2.json:")
            for path, val in b_unique:
                print(f"{path}:", val)
            print()

        print("The following is different between the two files")
        for path, v1, v2 in diff:
            print(f"Version 1 - {path}:", v1)
            print(f"Version 2 - {path}:", v2)
            print()
