'use strict'

const args = new URLSearchParams(location.search)

// localization
;[...document.querySelectorAll('[data-i18n]')].forEach((e) => {
  e.textContent = chrome.i18n.getMessage(e.dataset.i18n)
})

chrome.storage.local.get(
  {
    unprotectedWeb: true,
    protectedWeb: false,
    extension: false,
    since: 7,
    selector: true,
    closedExplorer: true,
    deletecache: true,
    deletecookies: true,
    deletedownloads: true,
    deleteformData: true,
    deletehistory: true,
    presets: [
      {
        data: 1,
        value: '1 Day',
      },
      {
        data: 3,
        value: '3 Days',
      },
      {
        data: 7,
        value: '1 Week',
      },
      {
        data: 30,
        value: '1 Month',
      },
      {
        data: 0,
        value: 'All Time',
      },
    ],
  },
  (prefs) => {
    console.log('appcache:' + prefs.deletecache)

    console.log('cache:' + prefs.deletecache)

    console.log('cookies:' + prefs.deletecookies)

    console.log('downloads:' + prefs.deletecookies)

    console.log('fileSystems:' + true)

    console.log('formData:' + prefs.deleteformData)

    console.log('history:' + prefs.deletehistory)
    document.getElementById('unprotectedWeb').checked = true
    document.getElementById('deletewhenclosed').checked = prefs.closedExplorer
    document.getElementById('since').value = prefs.since
    document.getElementById('start').checked = prefs.selector === false
    document.getElementById('deletecache').checked = prefs.deletecache
    document.getElementById('deletecookies').checked = prefs.deletecookies
    document.getElementById('deletedownloads').checked = prefs.deletedownloads
    document.getElementById('deleteformData').checked = prefs.deleteformData
    document.getElementById('deletehistory').checked = prefs.deletehistory
    for (const preset of prefs.presets) {
      const input = document.createElement('button')
      input.dataset.days = preset.data
      input.textContent = preset.value

      document.getElementById('presets').appendChild(input)
    }
  }
)

document.addEventListener('change', () =>
  chrome.storage.local.set({
    unprotectedWeb: true,
    protectedWeb: false,
    extension: false,
    since: Math.max(0, Number(document.getElementById('since').value)),
    selector: document.getElementById('start').checked === false,
    closedExplorer: document.getElementById('deletewhenclosed').checked,
    deletecache: document.getElementById('deletecache').checked,
    deletecookies: document.getElementById('deletecookies').checked,
    deletedownloads: document.getElementById('deletedownloads').checked,
    deleteformData: document.getElementById('deleteformData').checked,
    deletehistory: document.getElementById('deletehistory').checked,
  })
)

document.getElementById('run').onclick = () =>
  chrome.runtime.sendMessage(
    {
      method: 'clean',
    },
    () => {
      if (args.get('mode') === 'popup') {
        document.title = 'Please wait...'
        setTimeout(() => window.close(), 1000)
      }
    }
  )

document.getElementById('presets').onclick = (e) => {
  const v = e.target.dataset.days
  if (v) {
    document.getElementById('since').value = v
    document.dispatchEvent(new Event('change'))
    document.getElementById('since').focus()
  }
}
