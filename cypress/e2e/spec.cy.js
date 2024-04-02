describe('template spec', () => {
  it('passes', () => {
    cy.visit('http://local.mailmunch.co:3001')

    // check if server is running
    const checkIfServerIsRunning = () => {
      cy.request('http://local.mailmunch.co:3000')
        .its('status')
        .then((status) => {
          if (status === 200) {
            const url = 'http://local.mailmunch.co:3000'
            const user = {
              email: 'admin@mailmunch.com',
              password: '3g4glte',
              keep_me_logged_in: false
            }
          
            cy.request({
              url: `${url}/api/v1/auth/sign_in`,
              method: 'POST',
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
              },
              body: JSON.stringify({
                user
              })
            })
              .its('body')
              .then((body) => {
                window.localStorage.setItem("user:token", body.token)
                cy.visit('http://local.mailmunch.co:3001')
              })
          } else {
            console.log('Server is not running')
            cy.wait(30000).then(() => {
              checkIfServerIsRunning()
            })
          }
        })
    }

    checkIfServerIsRunning()
  })
})