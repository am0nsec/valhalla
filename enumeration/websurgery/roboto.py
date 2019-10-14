"""
Author: Amonsec
"""
import argparse
import requests
import sys

"""
Color variables
"""
_RED = '\x1b[1;31m'
_BLU = '\x1b[1;34m'
_GRE = '\x1b[1;32m'
_YEL = '\x1b[1;33m'
_RST = '\x1b[0;0;0m'


def success_message(message: str = None) -> str:
    """
    Return the formatted message for an success

    :param message:
    :return:
    """
    return '[{}+{}] {}'.format(_GRE, _RST, message)


def error_message(message: str = None) -> str:
    """
    Return the formatted message for an error

    :param message:
    :return:
    """
    return '[{}+{}] {}'.format(_RED, _RST, message)


def info_message(message: str = None) -> str:
    """
    Return the formatted message for an information

    :param message:
    :return:
    """
    return '[{}+{}] {}'.format(_BLU, _RST, message)


def check_url(url: str = None) -> bool:
    """
    Used to check if the domain name / server exists

    :param url: str
    :return: bool
    """
    try:
        requests.get(url)
        return True
    except requests.ConnectionError:
        return False


def check_robot_file(url: str = None) -> [bool, str, str]:
    """
    Call the URL and try to get the robots.txt file

    :param url: str
    :return: [bool, str, str]
    """
    if not url.endswith('/'):
        url += '/robots.txt'
    else:
        url += 'robots.txt'

    resp = requests.get(url)
    return [resp.status_code == 200, resp.status_code, resp.text]


def get_all_paths(text: [str] = None) -> [str, int]:
    """
    Return the list of all paths and the length of the array

    :param text: [str]
    :return: [str, int]
    """
    path_list = text.split('\n')
    ret = []
    for x in path_list:
        if 'Disallow' in x and '*' not in x:
            if len(x.split('Disallow: ')) > 1:
                ret.append(x.split('Disallow: ')[1])
        elif 'Allow' in x and '*' not in x:
            if len(x.split('Allow: ')) > 1:
                ret.append(x.split('Allow: ')[1])
        else:
            pass

    return [ret, len(ret)]


def check_them_all(url: str = None, paths: [str] = None) -> None:
    """
    Check all candidates to get the status code

    :param url: str
    :param paths: [str]
    :return: None
    """
    path = None
    for x in paths:
        if url.endswith('/') and x[0:1:] == '/':
            path = url + x[1::]
        elif url.endswith('/') and not x[0:1:] == '/':
            path = url + x
        elif not url.endswith('/') and x[0:1:] == '/':
            path = url + x
        elif not url.endswith('/') and not x[0:1:] == '/':
            path = url + '/' + x

        resp = requests.get(path)
        if 200 <= resp.status_code < 300:
            print('{} {} {}  ->  {} (Length: {})'
                  .format(_GRE, resp.status_code, _RST, path, resp.headers.get('content-length')))
        elif 300 <= resp.status_code < 400:
            print('{} {} {}  ->  {} (Length: {})'
                  .format(_YEL, resp.status_code, _RST, path, resp.headers.get('content-length')))
        elif 400 <= resp.status_code < 500:
            print('{} {} {}  ->  {} (Length: {})'
                  .format(_RED, resp.status_code, _RST, path, resp.headers.get('content-length')))
        elif 500 <= resp.status_code < 600:
            print('{} {} {}  ->  {} (Length: {})'
                  .format(_BLU, resp.status_code, _RST, path, resp.headers.get('content-length')))


if __name__ == '__main__':
    """
    Entry point of the script
    """
    print(info_message('Description: robots.txt finder and crawler'))
    print(info_message('Author: {}Amonsec{}'.format(_RED, _RST)))
    print(info_message('Version: {}1.0{}\n'.format(_YEL, _RST)))

    """
    Main variables
    """
    parser = argparse.ArgumentParser(description='robots.txt finder and crawler')
    parser.add_argument('-v', '--verbosity', help='Increase output verbosity', action='store_true')
    parser.add_argument('-u', '--url', help='The url or the IP to check', required=True)
    args = parser.parse_args()

    """
    Check if the URL exist
    """
    print(info_message('Checking if the URL exists ...'))
    if not check_url(args.url):
        print(error_message('Failed to establish a new connection'))
        sys.exit(1)
    else:
        print(success_message('URL can be establish\n'))

    """
    Check if the robots.txt file exists
    """
    print(info_message('Checking for the robots.txt file ...'))
    answer, status_code, robot_content = check_robot_file(args.url)
    if not answer:
        print(error_message('robots.txt not found'))
        if args.verbosity:
            print(_RED + str(status_code) + _RST + '  -> ' + args.url + '\n')
        sys.exit(1)
    else:
        print(success_message('robots.txt successfully found'))
        if args.verbosity:
            print(_GRE + str(status_code) + _RST + '  -> ' + args.url + '\n')

    """
    Create a list of all potential paths
    """
    candidates, candidates_length = get_all_paths(robot_content)

    """
    Testing all candidates
    """
    print(info_message('Checking all candidates ...'))
    print(info_message('Candidates: {}'.format(candidates_length)))
    check_them_all(args.url, candidates)

    """
    End of Script
    """
